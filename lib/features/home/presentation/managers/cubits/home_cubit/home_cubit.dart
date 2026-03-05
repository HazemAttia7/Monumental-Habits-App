import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pixel_true_app/core/enums/habit_comletion_state_enum.dart';
import 'package:pixel_true_app/core/helper/date_helper.dart';
import 'package:pixel_true_app/features/home/data/models/habit_model.dart';
import 'package:pixel_true_app/features/home/data/repos/habits_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HabitsRepo _repo;
  final String _uid;
  Timer? _debounceTimer;

  HomeCubit(this._repo, this._uid) : super(HomeInitial());

  Future<void> fetchHabits() async {
    emit(HabitsLoading());
    final result = await _repo.getHabits(_uid);
    result.fold(
      (failure) => emit(HabitsError(failure.errMessage)),
      (habits) => emit(HabitsLoaded(habits)),
    );
  }

  void cycleHabitStatus(String habitId, DateTime date) {
    if (state is! HabitsLoaded) return;
    final habits = (state as HabitsLoaded).habits;
    final habit = habits.firstWhere((h) => h.id == habitId);
    final key = dateKey(date);
    final current = habit.logs[key] ?? enHabitCompletionState.none;
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
    });
  }

  Future<void> deleteHabit(String habitId) async {
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

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}
