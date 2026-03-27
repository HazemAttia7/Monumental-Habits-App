part of 'habits_cubit.dart';

@immutable
sealed class HabitsState {}

final class HabitsInitial extends HabitsState {}

final class HabitsLoading extends HabitsState {}

final class HabitsLoaded extends HabitsState {
  final List<Habit> habits;
  late final List<Habit> inProgressHabits;
  late final List<Habit> completedHabits;
  late final List<Habit> missedHabits;
  List<Habit> habitsForStatus(enFilterHabitsByStatus status) =>
      switch (status) {
        enFilterHabitsByStatus.completed => completedHabits,
        enFilterHabitsByStatus.missed => missedHabits,
        enFilterHabitsByStatus.inProgress => inProgressHabits,
        _ => habits,
      };

  HabitsLoaded(this.habits) {
    inProgressHabits = habits
        .where((h) => h.status == enHabitStatus.inProgress)
        .toList();
    completedHabits = habits
        .where((h) => h.status == enHabitStatus.completed)
        .toList();
    missedHabits = habits
        .where((h) => h.status == enHabitStatus.missed)
        .toList();
  }
}

final class HabitsError extends HabitsState {
  final String errMessage;
  HabitsError(this.errMessage);
}
