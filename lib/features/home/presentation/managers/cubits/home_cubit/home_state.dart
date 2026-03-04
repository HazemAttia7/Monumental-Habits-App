part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HabitsLoading extends HomeState {}

final class HabitsLoaded extends HomeState {
  final List<Habit> habits;
  HabitsLoaded(this.habits);
}

final class HabitsError extends HomeState {
  final String errMessage;
  HabitsError(this.errMessage);
}
