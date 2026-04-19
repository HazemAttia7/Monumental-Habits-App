import 'package:dartz/dartz.dart';
import 'package:pixel_true_app/core/errors/failure.dart';
import 'package:pixel_true_app/features/community/data/models/comment_model.dart';

abstract class CommentsRepo {
  Future<Either<Failure, List<Comment>>> getComments(String postId);
  Stream<Either<Failure, List<Comment>>> watchComments(String postId);
}
