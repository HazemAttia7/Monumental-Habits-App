import 'package:dartz/dartz.dart';
import 'package:pixel_true_app/core/errors/failure.dart';
import 'package:pixel_true_app/features/courses/data/models/course_model.dart';

abstract class CoursesRepo {
  Future<Either<Failure, List<Course>>> getCourses();
}