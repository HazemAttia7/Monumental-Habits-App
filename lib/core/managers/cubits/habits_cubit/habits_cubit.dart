import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pixel_true_app/core/enums/habit_enums.dart';
import 'package:pixel_true_app/core/helper/date_helper.dart';
import 'package:pixel_true_app/core/services/notification_service.dart';
import 'package:pixel_true_app/features/home/data/models/habit_model.dart';
import 'package:pixel_true_app/features/home/data/repos/habits_repo.dart';

part 'habits_state.dart';

// TODO : check if methods like (add , update , etc) should be implemented like cycleHabitStatus using debounce
// TODO : test syncing data when offline : probably syncing isn't properly working and offline data are lost
class HabitsCubit extends Cubit<HabitsState> {
  final HabitsRepo _repo;
  final String _uid;
  Timer? _debounceTimer;
  final NotificationService _notificationService;

  HabitsCubit(this._repo, this._uid, this._notificationService)
    : super(HabitsInitial());

  Future<void> fetchHabits() async {
    emit(HabitsLoading());
    final result = await _repo.getHabits(_uid);
    result.fold((failure) => emit(HabitsError(failure.errMessage)), (habits) {
      emit(
        HabitsLoaded(
          habits..sort((a, b) => a.createdAt.compareTo(b.createdAt)),
        ),
      );
      for (final habit in habits) {
        if (habit.reminders.isNotEmpty) {
          _notificationService.scheduleHabitReminders(habit);
        }
      }
    });
  }

  void cycleHabitStatus(String habitId, DateTime date) {
    if (state is! HabitsLoaded) return;
    final habits = (state as HabitsLoaded).habits;
    final habit = habits.firstWhere((h) => h.id == habitId);
    final key = dateKey(date);
    final current = habit.logs[key] ?? enHabitDailyStatus.none;
    final next = current.next();

    // Instant UI update
    final updated = habit.copyWith(logs: Map.from(habit.logs)..[key] = next);
    emit(
      HabitsLoaded(habits.map((h) => h.id == habitId ? updated : h).toList()),
    );

    // Debounced write
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 800), () {
      _repo.updateHabitLog(_uid, habitId, key, next);
    });
  }

  Future<void> addHabit(Habit habit) async {
    final result = await _repo.addHabit(_uid, habit);
    result.fold((failure) => emit(HabitsError(failure.errMessage)), (_) {
      if (state is HabitsLoaded) {
        emit(HabitsLoaded([...(state as HabitsLoaded).habits, habit]));
      }
      if (habit.reminders.isNotEmpty) {
        _notificationService.scheduleHabitReminders(habit);
      }
    });
  }

  Future<void> deleteHabit(String habitId) async {
    await _notificationService.cancelHabitReminders(habitId);
    final result = await _repo.deleteHabit(_uid, habitId);
    result.fold((failure) => emit(HabitsError(failure.errMessage)), (_) {
      if (state is HabitsLoaded) {
        final updated = (state as HabitsLoaded).habits
            .where((h) => h.id != habitId)
            .toList();
        emit(HabitsLoaded(updated));
      }
    });
  }

  Future<void> updateHabitStatus(String habitId, enHabitStatus status) async {
    if (state is! HabitsLoaded) return;
    final habits = (state as HabitsLoaded).habits;

    // Instant UI update
    final updated = habits.map((h) {
      return h.id == habitId ? h.copyWith(status: status) : h;
    }).toList();
    emit(HabitsLoaded(updated));

    // Persist
    await _repo.updateHabitStatus(_uid, habitId, status);
  }

  Future<void> updateHabit(Habit habit) async {
    if (state is! HabitsLoaded) return;
    final habits = (state as HabitsLoaded).habits;

    // Instant UI update
    emit(
      HabitsLoaded(habits.map((h) => h.id == habit.id ? habit : h).toList()),
    );

    // Persist
    await _repo.updateHabit(_uid, habit);
    if (habit.reminders.isNotEmpty) {
      // Reschedule with new reminders/frequency
      await _notificationService.scheduleHabitReminders(habit);
    } else {
      // User turned off notifications → cancel all
      await _notificationService.cancelHabitReminders(habit.id);
    }
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}
