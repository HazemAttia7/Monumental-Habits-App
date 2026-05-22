import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';
import 'package:pixel_true_app/core/enums/habit_enums.dart';
import 'package:pixel_true_app/core/enums/habits_history_enums.dart';
import 'package:pixel_true_app/core/helper/date_helper.dart';
import 'package:pixel_true_app/core/services/notification_service.dart';
import 'package:pixel_true_app/features/home/data/models/habit_model.dart';
import 'package:pixel_true_app/features/home/data/repos/habits_repo.dart';

part 'habits_state.dart';

class HabitsCubit extends Cubit<HabitsState> {
  final HabitsRepo _repo;
  final String _uid;
  Timer? _debounceTimer;
  final NotificationService _notificationService;
  final Connectivity _connectivity;
  StreamSubscription? _connectivitySubscription;
  final Map<String, enHabitDailyStatus> _pendingLogUpdates = {};

  HabitsCubit(
    this._repo,
    this._uid,
    this._notificationService,
    this._connectivity,
  ) : super(HabitsInitial()) {
    _listenToConnectivity();
  }

  void _listenToConnectivity() {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((
      results,
    ) {
      final isOnline = results.any((r) => r != ConnectivityResult.none);

      if (isOnline) {
        _syncNow();
      }
    });
  }

  /// Syncs unsynced local changes to Firestore without touching the UI state.
  Future<void> _syncNow() async {
    if (state is! HabitsLoaded) return;

    final result = await _repo.syncPendingChanges(_uid);

    result.fold((_) {}, (updatedHabits) async {
      if (updatedHabits == null) return;

      updatedHabits.sort((a, b) => a.createdAt.compareTo(b.createdAt));

      emit(HabitsLoaded(updatedHabits));

      await _updateBestStreak(updatedHabits);
    });
  }

  Future<void> fetchHabits() async {
    emit(HabitsLoading());

    final result = await _repo.getHabits(_uid);

    result.fold(
      (failure) {
        emit(HabitsError(failure.errMessage));
      },
      (habits) async {
        habits.sort((a, b) => a.createdAt.compareTo(b.createdAt));

        emit(HabitsLoaded(habits));

        _rescheduleAllNotifications(habits);

        await _updateBestStreak(habits);
      },
    );
  }

  /// Reschedules notifications only for habits whose reminders have changed.
  void _rescheduleAllNotifications(List<Habit> habits) {
    for (final habit in habits) {
      if (habit.reminders.isNotEmpty) {
        _notificationService.scheduleHabitReminders(habit);
      } else {
        _notificationService.cancelHabitReminders(habit.id);
      }
    }
  }

  void cycleHabitStatus(String habitId, DateTime date) {
    if (state is! HabitsLoaded) return;

    final habits = (state as HabitsLoaded).habits;

    final habit = habits.firstWhere((h) => h.id == habitId);

    final key = dateKey(date);

    final current = habit.logs[key] ?? enHabitDailyStatus.none;

    final next = current.next();

    final pendingKey = '${habitId}_$key';

    _pendingLogUpdates[pendingKey] = next;

    final updatedHabit = habit.copyWith(
      logs: Map.from(habit.logs)..[key] = next,
    );

    final updatedHabits = habits
        .map((h) => h.id == habitId ? updatedHabit : h)
        .toList();

    emit(HabitsLoaded(updatedHabits));

    _debounceTimer?.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 800), () async {
      final latestStatus = _pendingLogUpdates[pendingKey];

      if (latestStatus == null) return;

      _pendingLogUpdates.remove(pendingKey);

      final result = await _repo.updateHabitLog(
        _uid,
        habitId,
        key,
        latestStatus,
        updatedHabit,
      );

      result.fold(
        (failure) {
          if (state is HabitsLoaded) {
            final currentHabits = (state as HabitsLoaded).habits;

            emit(
              HabitsLoaded(
                currentHabits.map((h) => h.id == habitId ? habit : h).toList(),
              ),
            );
          }
        },
        (_) async {
          if (state is HabitsLoaded) {
            await _updateBestStreak((state as HabitsLoaded).habits);
          }
        },
      );
    });
  }

  Future<void> addHabit(Habit habit) async {
    if (state is! HabitsLoaded) return;

    final habits = (state as HabitsLoaded).habits;

    final updatedHabits = [...habits, habit];

    emit(HabitsLoaded(updatedHabits));

    final result = await _repo.addHabit(_uid, habit);

    result.fold(
      (failure) {
        if (state is HabitsLoaded) {
          emit(
            HabitsLoaded(
              (state as HabitsLoaded).habits
                  .where((h) => h.id != habit.id)
                  .toList(),
            ),
          );
        }
      },
      (_) async {
        if (habit.reminders.isNotEmpty) {
          _notificationService.scheduleHabitReminders(habit);
        }

        if (state is HabitsLoaded) {
          await _updateBestStreak((state as HabitsLoaded).habits);
        }
      },
    );
  }

  Future<void> deleteHabit(String habitId) async {
    if (state is! HabitsLoaded) return;

    final habits = (state as HabitsLoaded).habits;

    final habit = habits.firstWhere((h) => h.id == habitId);

    final updatedHabits = habits.where((h) => h.id != habitId).toList();

    emit(HabitsLoaded(updatedHabits));

    await _notificationService.cancelHabitReminders(habitId);

    final result = await _repo.deleteHabit(_uid, habitId);

    result.fold(
      (failure) {
        if (state is HabitsLoaded) {
          emit(HabitsLoaded([...(state as HabitsLoaded).habits, habit]));
        }

        if (habit.reminders.isNotEmpty) {
          _notificationService.scheduleHabitReminders(habit);
        }
      },
      (_) async {
        if (state is HabitsLoaded) {
          await _updateBestStreak((state as HabitsLoaded).habits);
        }
      },
    );
  }

  Future<void> updateHabitStatus(String habitId, enHabitStatus status) async {
    if (state is! HabitsLoaded) return;

    final habits = (state as HabitsLoaded).habits;

    final original = habits.firstWhere((h) => h.id == habitId);

    final updatedHabits = habits
        .map((h) => h.id == habitId ? h.copyWith(status: status) : h)
        .toList();

    emit(HabitsLoaded(updatedHabits));

    if (status == enHabitStatus.inProgress) {
      if (original.reminders.isNotEmpty) {
        _notificationService.scheduleHabitReminders(original);
      }
    } else {
      await _notificationService.cancelHabitReminders(habitId);
    }

    final result = await _repo.updateHabitStatus(_uid, habitId, status);

    result.fold(
      (failure) {
        if (state is HabitsLoaded) {
          emit(
            HabitsLoaded(
              (state as HabitsLoaded).habits
                  .map((h) => h.id == habitId ? original : h)
                  .toList(),
            ),
          );
        }

        if (original.reminders.isNotEmpty) {
          _notificationService.scheduleHabitReminders(original);
        } else {
          _notificationService.cancelHabitReminders(habitId);
        }
      },
      (_) async {
        if (state is HabitsLoaded) {
          await _updateBestStreak((state as HabitsLoaded).habits);
        }
      },
    );
  }

  Future<void> updateHabit(Habit habit) async {
    if (state is! HabitsLoaded) return;

    final habits = (state as HabitsLoaded).habits;

    final original = habits.firstWhere((h) => h.id == habit.id);

    final updatedHabits = habits
        .map((h) => h.id == habit.id ? habit : h)
        .toList();

    emit(HabitsLoaded(updatedHabits));

    final result = await _repo.updateHabit(_uid, habit);

    result.fold(
      (failure) {
        if (state is HabitsLoaded) {
          emit(
            HabitsLoaded(
              (state as HabitsLoaded).habits
                  .map((h) => h.id == habit.id ? original : h)
                  .toList(),
            ),
          );
        }
      },
      (_) async {
        if (habit.reminders.isNotEmpty) {
          _notificationService.scheduleHabitReminders(habit);
        } else {
          _notificationService.cancelHabitReminders(habit.id);
        }

        if (state is HabitsLoaded) {
          await _updateBestStreak((state as HabitsLoaded).habits);
        }
      },
    );
  }

  Future<void> _updateBestStreak(List<Habit> habits) async {
    int bestStreak = 0;

    for (final habit in habits) {
      if (habit.currentStreak > bestStreak) {
        bestStreak = habit.currentStreak;
      }
    }

    await _repo.updateUserBestStreak(_uid, bestStreak);
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    _connectivitySubscription?.cancel();
    return super.close();
  }
}
