import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:pixel_true_app/core/errors/failure.dart';
import 'package:pixel_true_app/features/auth/data/repos/user_profile_repo.dart';
import 'package:pixel_true_app/models/user_profile_model.dart';

class UserProfileRepoImpl implements UserProfileRepo {
  final FirebaseFirestore _firestore;

  UserProfileRepoImpl({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<Either<Failure, UserProfile>> getUserProfile({
    required String uid,
  }) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();

      if (!doc.exists) {
        return const Left(FirebaseFailure("User profile not found"));
      }
      final jsonData = doc.data()!;

      return Right(UserProfile.fromJson(jsonData));
    } on Exception catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }
}
