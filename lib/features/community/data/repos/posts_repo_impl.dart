import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:pixel_true_app/core/errors/failure.dart';
import 'package:pixel_true_app/features/community/data/models/post_model.dart';
import 'package:pixel_true_app/features/community/data/repos/posts_repo.dart';

class PostsRepoImpl implements PostsRepo {
  final FirebaseFirestore _firestore;

  PostsRepoImpl({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _ref() =>
      _firestore.collection('posts');

  @override
  Stream<Either<Failure, List<Post>>> watchPosts() async* {
    try {
      yield* _ref()
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map<Either<Failure, List<Post>>>(
            (snapshot) => Right(
              snapshot.docs.map((doc) => Post.fromJson(doc.data())).toList(),
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
  Future<Either<Failure, bool>> createPost(Post post) async {
    try {
      final docRef = _ref().doc();
      final newPost = post.copyWith(id: docRef.id);
      await docRef.set(newPost.toJson());
      return const Right(true);
    } catch (e) {
      return Left(
        e is FirebaseException
            ? FirebaseFailure.fromFirestore(e)
            : FirebaseFailure(e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> editPost(
    String postId,
    String newContent,
  ) async {
    try {
      await _ref().doc(postId).update({
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

  @override
  String generatePostId() => _ref().doc().id;
}
