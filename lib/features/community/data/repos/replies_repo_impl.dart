import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:pixel_true_app/core/errors/failure.dart';
import 'package:pixel_true_app/features/community/data/models/reply_model.dart';
import 'package:pixel_true_app/features/community/data/repos/replies_repo.dart';

class RepliesRepoImpl implements RepliesRepo {
  final FirebaseFirestore _firestore;

  RepliesRepoImpl({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _ref(
    String postId,
    String commentId,
  ) => _firestore.collection('posts/$postId/comments/$commentId/replies');

  @override
  Stream<Either<Failure, List<Reply>>> watchReplies(
    String postId,
    String commentId,
  ) async* {
    try {
      yield* _ref(postId, commentId)
          .orderBy('createdAt', descending: false)
          .snapshots()
          .map<Either<Failure, List<Reply>>>(
            (snapshot) => Right(
              snapshot.docs
                  .map((d) => Reply.fromJson(d.data(), postId, commentId))
                  .toList(),
            ),
          );
    } catch (e) {
      if (e is FirebaseException) {
        yield Left(FirebaseFailure.fromFirestore(e));
      } else {
        yield Left(FirebaseFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addReply(Reply reply) async {
    try {
      await _ref(
        reply.postId,
        reply.commentId,
      ).doc(reply.id).set(reply.toJson());
      return const Right(unit);
    } catch (e) {
      if (e is FirebaseException) {
        return Left(FirebaseFailure.fromFirestore(e));
      } else {
        return Left(FirebaseFailure(e.toString()));
      }
    }
  }

  @override
  String generateReplyId(String postId, String commentId) {
    return _ref(postId, commentId).doc().id;
  }
}
