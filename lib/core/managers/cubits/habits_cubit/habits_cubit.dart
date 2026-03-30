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
    this._connectivity, // inject Connectivity
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
  /// Called automatically when internet reconnects.
  Future<void> _syncNow() async {
    if (state is! HabitsLoaded) return;
    final result = await _repo.syncPendingChanges(_uid);
    result.fold(
      (_) {}, // sync failed silently — will retry next reconnect
      (updatedHabits) {
        if (updatedHabits == null) return; // nothing changed
        emit(
          HabitsLoaded(
            updatedHabits..sort((a, b) => a.createdAt.compareTo(b.createdAt)),
          ),
        );
      },
    );
  }

  Future<void> fetchHabits() async {
    emit(HabitsLoading());
    final result = await _repo.getHabits(_uid);
    result.fold((failure) => emit(HabitsError(failure.errMessage)), (habits) {
      habits.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      emit(HabitsLoaded(habits));
      _rescheduleAllNotifications(habits);
    });
  }

  /// Reschedules notifications only for habits whose reminders have changed,
  /// avoiding duplicate notifications on repeated fetchHabits calls.
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

    // Track the latest intended value for this habit+date
    final pendingKey = '${habitId}_$key';
    _pendingLogUpdates[pendingKey] = next;

    // Instant optimistic UI update
    final updatedHabit = habit.copyWith(
      logs: Map.from(habit.logs)..[key] = next,
    );
    emit(
      HabitsLoaded(
        habits.map((h) => h.id == habitId ? updatedHabit : h).toList(),
      ),
    );

    // Debounced write — always writes the latest value, not a captured closure value
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
        updatedHabit, // pass full habit so repo doesn't re-fetch stale data
      );

      result.fold(
        (failure) {
          // Roll back to the original state on failure
          if (state is HabitsLoaded) {
            final currentHabits = (state as HabitsLoaded).habits;
            emit(
              HabitsLoaded(
                currentHabits.map((h) => h.id == habitId ? habit : h).toList(),
              ),
            );
          }
        },
        (_) {}, // success — UI already reflects the change
      );
    });
  }

  Future<void> addHabit(Habit habit) async {
    if (state is! HabitsLoaded) return;
    final habits = (state as HabitsLoaded).habits;

    // Immediate UI update
    emit(HabitsLoaded([...habits, habit]));

    final result = await _repo.addHabit(_uid, habit);
    result.fold(
      (failure) {
        // Roll back — remove the habit we just added
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
      (_) {
        if (habit.reminders.isNotEmpty) {
          _notificationService.scheduleHabitReminders(habit);
        }
      },
    );
  }

  Future<void> deleteHabit(String habitId) async {
    if (state is! HabitsLoaded) return;
    final habits = (state as HabitsLoaded).habits;
    final habit = habits.firstWhere((h) => h.id == habitId);

    emit(HabitsLoaded(habits.where((h) => h.id != habitId).toList()));
    // Cancel notification after immediate UI update
    await _notificationService.cancelHabitReminders(habitId);

    final result = await _repo.deleteHabit(_uid, habitId);
    result.fold((failure) {
      // Roll back — restore the habit and its notification
      if (state is HabitsLoaded) {
        emit(HabitsLoaded([...(state as HabitsLoaded).habits, habit]));
      }
      if (habit.reminders.isNotEmpty) {
        _notificationService.scheduleHabitReminders(habit);
      }
    }, (_) {});
  }

  Future<void> updateHabitStatus(String habitId, enHabitStatus status) async {
    if (state is! HabitsLoaded) return;

    final habits = (state as HabitsLoaded).habits;
    final original = habits.firstWhere((h) => h.id == habitId);

    // Optimistic UI update
    emit(
      HabitsLoaded(
        habits
            .map((h) => h.id == habitId ? h.copyWith(status: status) : h)
            .toList(),
      ),
    );

    // Handle notifications based on status
    if (status == enHabitStatus.inProgress) {
      // Back to in progress → reschedule if has reminders
      if (original.reminders.isNotEmpty) {
        _notificationService.scheduleHabitReminders(original);
      }
    } else {
      // Completed or missed → cancel reminders, no point notifying
      await _notificationService.cancelHabitReminders(habitId);
    }

    final result = await _repo.updateHabitStatus(_uid, habitId, status);
    result.fold((failure) {
      // Roll back on failure
      if (state is HabitsLoaded) {
        emit(
          HabitsLoaded(
            (state as HabitsLoaded).habits
                .map((h) => h.id == habitId ? original : h)
                .toList(),
          ),
        );
      }
      // Roll back notification too
      if (original.reminders.isNotEmpty) {
        _notificationService.scheduleHabitReminders(original);
      } else {
        _notificationService.cancelHabitReminders(habitId);
      }
    }, (_) {});
  }

  Future<void> updateHabit(Habit habit) async {
    if (state is! HabitsLoaded) return;

    final habits = (state as HabitsLoaded).habits;
    final original = habits.firstWhere((h) => h.id == habit.id);

    // Optimistic UI update
    emit(
      HabitsLoaded(habits.map((h) => h.id == habit.id ? habit : h).toList()),
    );

    final result = await _repo.updateHabit(_uid, habit);
    result.fold(
      (failure) {
        // Roll back on failure
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
      (_) {
        // Sync notifications with new habit config
        if (habit.reminders.isNotEmpty) {
          _notificationService.scheduleHabitReminders(habit);
        } else {
          _notificationService.cancelHabitReminders(habit.id);
        }
      },
    );
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    _connectivitySubscription?.cancel();
    return super.close();
  }
}
