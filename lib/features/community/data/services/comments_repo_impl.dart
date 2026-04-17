import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:pixel_true_app/core/errors/failure.dart';
import 'package:pixel_true_app/features/community/data/models/comment_model.dart';
import 'package:pixel_true_app/features/community/data/services/comments_repo.dart';

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
}
