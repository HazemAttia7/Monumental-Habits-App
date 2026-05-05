import 'package:dartz/dartz.dart';
import 'package:pixel_true_app/core/errors/failure.dart';
import 'package:pixel_true_app/features/community/data/models/post_model.dart';

abstract class PostsRepo {
  Future<Either<Failure, List<Post>>> getPosts();
  Future<Either<Failure, bool>> createPost(Post post);
  Future<Either<Failure, Unit>> deletePost(Post post);
  Future<Either<Failure, Unit>> likePost(String postId, String uid);
  Future<Either<Failure, Unit>> unlikePost(String postId, String uid);
  String generatePostId();
}
