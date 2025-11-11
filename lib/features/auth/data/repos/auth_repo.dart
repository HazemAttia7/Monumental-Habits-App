import 'package:dartz/dartz.dart';
import 'package:pixel_true_app/core/errors/failure.dart';
import 'package:pixel_true_app/features/auth/data/models/app_user.dart';

abstract class AuthRepo {
  Future<Either<Failure, AppUser?>> getCurrentUser();

  Future<Either<Failure, AppUser>> loginWithEmailPassword({
    required String email,
    required String password,
  });
  Future<Either<Failure, AppUser>> signUpWithEmailPassword({
    required String email,
    required String password,
  });
  Future<Either<Failure, Unit>> logout();
}
