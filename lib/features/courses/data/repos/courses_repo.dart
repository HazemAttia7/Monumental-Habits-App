import 'package:dartz/dartz.dart';
import 'package:pixel_true_app/core/errors/failure.dart';
import 'package:pixel_true_app/features/courses/data/models/course_model.dart';

abstract class CoursesRepo {
  Future<Either<Failure, List<Course>>> getCourses();
  Future<Either<Failure, Unit>> toggleSaveCourse(
    String courseId,
    String uid,
    bool isSaved,
  );
  Future<Either<Failure, Unit>> updateProgress(
    String courseId,
    String uid,
    int lessonNumber,
  );
  Future<Either<Failure, Set<String>>> getSavedCourseIds(String uid);
}
