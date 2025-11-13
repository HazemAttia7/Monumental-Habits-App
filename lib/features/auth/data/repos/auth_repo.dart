import 'package:dartz/dartz.dart';
import 'package:pixel_true_app/core/errors/failure.dart';
import 'package:pixel_true_app/features/auth/data/models/app_user.dart';
import 'package:flutter/material.dart';


abstract class AuthRepo {
  Future<Either<Failure, AppUser?>> getCurrentUser();

  Future<Either<Failure, AppUser>> loginWithEmailPassword({
    required String email,
    required String password,
  });
  Future<Either<Failure, AppUser>> signUpWithEmailPassword(
    BuildContext context, {
    required String username,
    required String email,
    required String password,
    required bool emailMe,
  });
  Future<Either<Failure, Unit>> logout();

  Future<Either<Failure, Unit>> sendPasswordResetEmail({required String email});

  Future<Either<Failure, AppUser>> signUpWithGoogle();
}
