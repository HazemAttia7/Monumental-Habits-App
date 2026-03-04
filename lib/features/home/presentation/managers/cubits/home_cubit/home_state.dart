part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class LoadingUserData extends HomeState {}

final class LoadingSuccess extends HomeState {
  final List<Habit> habits;
  LoadingSuccess(this.habits);
}

final class LoadingFailure extends HomeState {
    final String errMessage;
  LoadingFailure(this.errMessage);
}
