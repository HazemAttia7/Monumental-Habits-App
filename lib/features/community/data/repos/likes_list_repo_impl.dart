import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:pixel_true_app/core/errors/failure.dart';
import 'package:pixel_true_app/features/community/data/repos/likes_list_repo.dart';
import 'package:pixel_true_app/models/user_profile_model.dart';

class LikesListRepoImpl implements LikesListRepo {

  @override
  Future<Either<Failure, List<UserProfile>>> getLikesListByUids(
    List<String> uids,
  ) async {
    try {
      if (uids.isEmpty) {
        return const Right([]);
      }

      List<UserProfile> users = [];

      // Firestore whereIn limit = 10
      for (int i = 0; i < uids.length; i += 10) {
        final batch = uids.sublist(
          i,
          i + 10 > uids.length ? uids.length : i + 10,
        );

        final querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('uid', whereIn: batch)
            .get();

        final batchUsers = querySnapshot.docs
            .map((doc) => UserProfile.fromJson(doc.data()))
            .toList();

        users.addAll(batchUsers);
      }

      return Right(users);
    } catch (e) {
      if (e is FirebaseException) {
        return Left(FirebaseFailure.fromFirestore(e));
      } else {
        return Left(FirebaseFailure(e.toString()));
      }
    }
  }
  
}
