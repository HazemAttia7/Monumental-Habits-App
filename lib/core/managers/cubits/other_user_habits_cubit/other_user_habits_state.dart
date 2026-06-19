part of 'other_user_habits_cubit.dart';

@immutable
sealed class OtherUserHabitsState {}

final class OtherUserHabitsInitial extends OtherUserHabitsState {}

final class OtherUserHabitsLoading extends OtherUserHabitsState {}

final class OtherUserHabitsLoaded extends OtherUserHabitsState {
  final List<Habit> habits;
  OtherUserHabitsLoaded(this.habits);
}

final class OtherUserHabitsError extends OtherUserHabitsState {
  final String errMessage;
  OtherUserHabitsError(this.errMessage);
}
