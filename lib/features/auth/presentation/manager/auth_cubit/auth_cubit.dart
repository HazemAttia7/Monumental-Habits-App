import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pixel_true_app/features/auth/data/models/app_user.dart';
import 'package:pixel_true_app/features/auth/data/repos/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AppUser? _currentUser;

  AuthCubit(this.authRepo) : super(AuthInitial());

  AppUser? get currentUser => _currentUser;

  Future<void> checkAuth() async {
    emit(AuthLoading());
    final result = await authRepo.getCurrentUser();
    result.fold(
      (failure) {
        emit(AuthError(failure.errMessage));
        emit(Unauthenticated());
      },
      (user) {
        _currentUser = user;
        if (user != null) {
          emit(Authenticated(user: user));
        } else {
          emit(Unauthenticated());
        }
      },
    );
  }

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    final result = await authRepo.loginWithEmailPassword(
      email: email,
      password: password,
    );

    result.fold(
      (failure) {
        emit(AuthError(failure.errMessage));
        emit(Unauthenticated());
      },
      (user) {
        _currentUser = user;
        emit(Authenticated(user: user));
      },
    );
  }

  Future<void> signUp(
    BuildContext context, {
    required String username,
    required String email,
    required String password,
    bool emailMe = false,
  }) async {
    emit(AuthLoading());
    final result = await authRepo.signUpWithEmailPassword(
      context,
      username: username,
      email: email,
      password: password,
      emailMe: emailMe,
    );

    result.fold(
      (failure) {
        emit(AuthError(failure.errMessage));
        emit(Unauthenticated());
      },
      (user) async {
        _currentUser = user;
        emit(Authenticated(user: user));
      },
    );
  }

  Future<void> logout() async {
    final result = await authRepo.logout();
    result.fold(
      (failure) {
        emit(AuthError(failure.errMessage));
      },
      (_) {
        _currentUser = null;
        emit(Unauthenticated());
      },
    );
  }

  Future<bool> sendPasswordResetEmail({required String email}) async {
    final result = await authRepo.sendPasswordResetEmail(email: email);
    return result.fold(
      (failure) {
        emit(AuthError(failure.errMessage));
        return false;
      },
      (_) {
        return true;
      },
    );
  }

  Future<void> signupWithGoogle() async {
    final result = await authRepo.signUpWithGoogle();
    result.fold(
      (failure) {
        emit(AuthError(failure.errMessage));
        emit(Unauthenticated());
      },
      (_) {
        emit(Authenticated(user: _currentUser!));
      },
    );
  }
}
