import 'package:dartz/dartz.dart';
import 'package:pixel_true_app/core/errors/failure.dart';
import 'package:pixel_true_app/features/community/data/models/post_model.dart';

abstract class PostRepo {
  Future<Either<Failure, List<Post>>> getPosts();
  Future<Either<Failure, void>> createPost(Post post);
  Future<Either<Failure, void>> deletePost(Post post);
  Future<Either<Failure, void>> likePost(Post post);
  Future<Either<Failure, void>> unlikePost(Post post);
}
