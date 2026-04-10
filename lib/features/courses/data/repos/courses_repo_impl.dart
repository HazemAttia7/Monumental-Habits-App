import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:pixel_true_app/core/errors/failure.dart';
import 'package:pixel_true_app/features/courses/data/models/course_model.dart';
import 'package:pixel_true_app/features/courses/data/repos/courses_repo.dart';

class CoursesRepoImpl implements CoursesRepo {
  final FirebaseFirestore _firestore;

  CoursesRepoImpl({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference _ref() => _firestore.collection('courses');

  @override
  Future<Either<Failure, List<Course>>> getCourses() async {
    try {
      final snapshot = await _ref().get();

      final courses = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;

        return Course.fromJson(data, doc.id);
      }).toList();

      return Right(courses);
    } catch (e) {
      if (e is FirebaseException) {
        return Left(FirebaseFailure.fromFirestore(e));
      } else {
        return Left(FirebaseFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> saveCourse(String courseId, String uid) async {
    try {
      final docRef = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('courses')
          .doc(courseId);

      await docRef.set({
        'saved': true,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

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
  Future<Either<Failure, Unit>> unsaveCourse(
    String courseId,
    String uid,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('courses')
          .doc(courseId)
          .set({
            'saved': false,
            'updatedAt': FieldValue.serverTimestamp(),
          }, SetOptions(merge: true));

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
  Future<Either<Failure, Unit>> updateProgress(
    String courseId,
    String uid,
    int lessonNumber,
  ) async {
    try {
      final docRef = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('courses')
          .doc(courseId);

      await docRef.set({
        'lastWatchedLesson': lessonNumber,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

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
