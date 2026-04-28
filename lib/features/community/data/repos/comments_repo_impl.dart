import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:pixel_true_app/core/errors/failure.dart';
import 'package:pixel_true_app/features/community/data/models/comment_model.dart';
import 'package:pixel_true_app/features/community/data/repos/comments_repo.dart';

class CommentsRepoImpl extends CommentsRepo {
  final FirebaseFirestore _firestore;

  CommentsRepoImpl({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _commentsRef(String postId) =>
      _firestore.collection('posts/$postId/comments');

  @override
  Future<Either<Failure, List<Comment>>> getComments(String postId) async {
    try {
      final snapshot = await _commentsRef(postId).get();
      final comments = snapshot.docs
          .map((doc) => Comment.fromJson(doc.data(), postId))
          .toList();
      return Right(comments);
    } catch (e) {
      return Left(
        e is FirebaseException
            ? FirebaseFailure.fromFirestore(e)
            : FirebaseFailure(e.toString()),
      );
    }
  }

  @override
  Stream<Either<Failure, List<Comment>>> watchComments(String postId) async* {
    try {
      yield* _commentsRef(postId)
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
      yield Left(
        e is FirebaseException
            ? FirebaseFailure.fromFirestore(e)
            : FirebaseFailure(e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> addComment(Comment comment) async {
    try {
      await _commentsRef(comment.postId).doc(comment.id).set(comment.toJson());
      return const Right(unit);
    } catch (e) {
      return Left(
        e is FirebaseException
            ? FirebaseFailure.fromFirestore(e)
            : FirebaseFailure(e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> editComment(
    String postId,
    String commentId,
    String newContent,
  ) async {
    try {
      await _commentsRef(postId).doc(commentId).update({
        'content': newContent,
        'editedAt': FieldValue.serverTimestamp(),
      });
      return const Right(unit);
    } catch (e) {
      return Left(
        e is FirebaseException
            ? FirebaseFailure.fromFirestore(e)
            : FirebaseFailure(e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteComment(
    String postId,
    String commentId,
  ) async {
    try {
      await _commentsRef(postId).doc(commentId).delete();
      return const Right(unit);
    } catch (e) {
      return Left(
        e is FirebaseException
            ? FirebaseFailure.fromFirestore(e)
            : FirebaseFailure(e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> likeComment(
    String postId,
    String commentId,
    String uid,
  ) async {
    try {
      await _commentsRef(postId).doc(commentId).update({
        'likedByUids': FieldValue.arrayUnion([uid]),
      });
      return const Right(unit);
    } catch (e) {
      return Left(
        e is FirebaseException
            ? FirebaseFailure.fromFirestore(e)
            : FirebaseFailure(e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> unlikeComment(
    String postId,
    String commentId,
    String uid,
  ) async {
    try {
      await _commentsRef(postId).doc(commentId).update({
        'likedByUids': FieldValue.arrayRemove([uid]),
      });
      return const Right(unit);
    } catch (e) {
      return Left(
        e is FirebaseException
            ? FirebaseFailure.fromFirestore(e)
            : FirebaseFailure(e.toString()),
      );
    }
  }

  @override
  String generateCommentId(String postId) => _commentsRef(postId).doc().id;
}
