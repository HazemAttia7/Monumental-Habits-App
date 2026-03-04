part of 'user_profile_cubit.dart';

@immutable
sealed class UserProfileState {}

final class UserProfileInitial extends UserProfileState {}
final class UserProfileLoading extends UserProfileState {}
final class UserProfileLoaded extends UserProfileState {
  final UserProfile userProfile;
  UserProfileLoaded(this.userProfile);
}
final class UserProfileError extends UserProfileState {
  final String errMessage;
  UserProfileError(this.errMessage);
}
