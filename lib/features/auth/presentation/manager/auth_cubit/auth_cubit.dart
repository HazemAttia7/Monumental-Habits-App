import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pixel_true_app/features/auth/data/models/app_user.dart';
import 'package:pixel_true_app/features/auth/data/repos/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AppUser? _currentUser;

  AuthCubit(this.authRepo) : super(AuthInitial());

  AppUser? get currentUser => _currentUser;

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

  Future<void> signUp({required String email, required String password}) async {
    emit(AuthLoading());
    final result = await authRepo.signUpWithEmailPassword(
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

  Future<void> logout() async {
    await authRepo.logout();
    _currentUser = null;
    emit(Unauthenticated());
  }
}
