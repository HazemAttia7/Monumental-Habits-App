import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:pixel_true_app/core/errors/failure.dart';
import 'package:pixel_true_app/features/community/data/models/post_model.dart';
import 'package:pixel_true_app/features/community/data/services/post_repo.dart';

class PostRepoImpl implements PostRepo {
  final FirebaseFirestore _firestore;

  PostRepoImpl({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<Either<Failure, List<Post>>> getPosts() async {
    try {
      final snapshot = await _firestore.collection('posts').get();
      final posts = snapshot.docs
          .map((doc) => Post.fromJson(doc.data()))
          .toList();

      return Right(posts);
    } catch (e) {
      if (e is FirebaseException) {
        return Left(FirebaseFailure.fromFirestore(e));
      } else {
        return Left(FirebaseFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, void>> createPost(Post post) async {
    // TODO: implement createPost
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deletePost(Post post) async {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> likePost(Post post) async {
    // TODO: implement likePost
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> unlikePost(Post post) async {
    // TODO: implement unlikePost
    throw UnimplementedError();
  }
}
