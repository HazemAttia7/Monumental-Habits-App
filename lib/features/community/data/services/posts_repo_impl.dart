import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:pixel_true_app/core/errors/failure.dart';
import 'package:pixel_true_app/features/community/data/models/post_model.dart';
import 'package:pixel_true_app/features/community/data/services/posts_repo.dart';

class PostsRepoImpl implements PostsRepo {
  final FirebaseFirestore _firestore;

  PostsRepoImpl({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _ref() =>
      _firestore.collection('posts');

  @override
  Future<Either<Failure, List<Post>>> getPosts() async {
    try {
      final snapshot = await _ref()
          .orderBy('createdAt', descending: true)
          .get();
      final posts = snapshot.docs.map((doc) {
        return Post.fromJson(doc.data(), doc.id);
      }).toList();

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
  Future<Either<Failure, Unit>> createPost(Post post) async {
    try {
      final docRef = _ref().doc();

      final newPost = post.copyWith(id: docRef.id);

      await docRef.set(newPost.toJson());
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
  Future<Either<Failure, Unit>> deletePost(Post post) async {
    try {
      await _ref().doc(post.id).delete();
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
  Future<Either<Failure, Unit>> likePost(String postId, String uid) async {
    try {
      await _ref().doc(postId).update({
        'likedByUids': FieldValue.arrayUnion([uid]),
      });
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
  Future<Either<Failure, Unit>> unlikePost(String postId, String uid) async {
    try {
      await _ref().doc(postId).update({
        'likedByUids': FieldValue.arrayRemove([uid]),
      });
      return const Right(unit);
    } catch (e) {
      if (e is FirebaseException) {
        return Left(FirebaseFailure.fromFirestore(e));
      } else {
        return Left(FirebaseFailure(e.toString()));
      }
    }
  }
}
