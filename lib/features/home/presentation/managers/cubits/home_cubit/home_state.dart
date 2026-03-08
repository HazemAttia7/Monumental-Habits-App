part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HabitsLoading extends HomeState {}

final class HabitsLoaded extends HomeState {
  final List<Habit> habits;
  late final List<Habit> inProgressHabits;
  late final List<Habit> completedHabits;
  late final List<Habit> missedHabits;

  HabitsLoaded(this.habits) {
    inProgressHabits = habits.where((h) => h.status == enHabitStatus.inProgress).toList();
    completedHabits = habits.where((h) => h.status == enHabitStatus.completed).toList();
    missedHabits = habits.where((h) => h.status == enHabitStatus.missed).toList();
  }
}

final class HabitsError extends HomeState {
  final String errMessage;
  HabitsError(this.errMessage);
}
