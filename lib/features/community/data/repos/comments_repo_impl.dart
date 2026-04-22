import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:pixel_true_app/core/errors/failure.dart';
import 'package:pixel_true_app/features/community/data/models/comment_model.dart';
import 'package:pixel_true_app/features/community/data/repos/comments_repo.dart';

class CommentsRepoImpl extends CommentsRepo {
  final FirebaseFirestore _firestore;

  CommentsRepoImpl({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _ref() =>
      _firestore.collection('posts');

  @override
  Future<Either<Failure, List<Comment>>> getComments(String postId) async {
    try {
      final snapshot = await _ref().doc(postId).collection('comments').get();

      final comments = snapshot.docs.map((doc) {
        final data = doc.data();
        return Comment.fromJson(data, doc.id);
      }).toList();

      return Future.value(Right(comments));
    } catch (e) {
      if (e is FirebaseException) {
        return Future.value(Left(FirebaseFailure.fromFirestore(e)));
      } else {
        return Future.value(Left(FirebaseFailure(e.toString())));
      }
    }
  }

  @override
  Stream<Either<Failure, List<Comment>>> watchComments(String postId) async* {
    try {
      yield* _firestore
          .collection('posts/$postId/comments')
          .orderBy('createdAt', descending: false)
          .snapshots()
          .map<Either<Failure, List<Comment>>>(
            (snapshot) => Right(
              snapshot.docs
                  .map((d) => Comment.fromJson(d.data(), postId))
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
  Future<Either<Failure, Unit>> addComment(Comment comment) async {
    try {
      await _firestore
          .collection('posts/${comment.postId}/comments')
          .doc(comment.id)
          .set(comment.toJson());
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
  String generateCommentId(String postId) {
    return _firestore.collection('posts/$postId/comments').doc().id;
  }
}
