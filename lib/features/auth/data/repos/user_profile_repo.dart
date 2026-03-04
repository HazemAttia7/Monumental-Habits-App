import 'package:dartz/dartz.dart';
import 'package:pixel_true_app/core/errors/failure.dart';
import 'package:pixel_true_app/models/user_profile_model.dart';

abstract class UserProfileRepo {
  Future<Either<Failure, UserProfile>> getUserProfile({required String uid});
}
