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
}
