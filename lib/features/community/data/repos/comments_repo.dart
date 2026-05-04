import 'package:dartz/dartz.dart';
import 'package:pixel_true_app/core/errors/failure.dart';
import 'package:pixel_true_app/features/community/data/models/comment_model.dart';

abstract class CommentsRepo {
  Future<Either<Failure, List<Comment>>> getComments(String postId);
  Stream<Either<Failure, List<Comment>>> watchComments(String postId);
  Future<Either<Failure, bool>> addComment(Comment comment);
  Future<Either<Failure, Unit>> editComment(
    String postId,
    String commentId,
    String newContent,
  );
  Future<Either<Failure, Unit>> deleteComment(String postId, String commentId);
  String generateCommentId(String postId);
  Future<Either<Failure, Unit>> likeComment(
    String postId,
    String commentId,
    String uid,
  );
  Future<Either<Failure, Unit>> unlikeComment(
    String postId,
    String commentId,
    String uid,
  );
}
