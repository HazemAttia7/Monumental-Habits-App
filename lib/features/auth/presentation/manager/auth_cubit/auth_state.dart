part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthError extends AuthState {
  final String errMessage;
  AuthError(this.errMessage);
}

final class Authenticated extends AuthState with EquatableMixin {
  final AppUser user;
  Authenticated({required this.user});

  @override
  List<Object?> get props => [user];
}

final class Unauthenticated extends AuthState {}
