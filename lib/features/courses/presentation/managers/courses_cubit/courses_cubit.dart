import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pixel_true_app/core/enums/courses_enums.dart';
import 'package:pixel_true_app/features/courses/data/models/course_model.dart';
import 'package:pixel_true_app/features/courses/data/repos/courses_repo.dart';

part 'courses_state.dart';

class CoursesCubit extends Cubit<CoursesState> {
  final CoursesRepo coursesRepo;
  CoursesCubit(this.coursesRepo) : super(CoursesInitial());

  Future<void> getCourses() async {
    emit(CoursesLoading());
    final result = await coursesRepo.getCourses();
    result.fold(
      (failure) => emit(CoursesError(failure.errMessage)),
      (courses) => emit(CoursesLoaded(courses)),
    );
  }

  Future<void> saveCourse(String courseId, String uid) async {
    emit(CoursesLoading());
    final result = await coursesRepo.saveCourse(courseId, uid);
    result.fold(
      (failure) => emit(CoursesError(failure.errMessage)),
      (_) => getCourses(),
    );
  }

  Future<void> unsaveCourse(String courseId, String uid) async {
    emit(CoursesLoading());
    final result = await coursesRepo.unsaveCourse(courseId, uid);
    result.fold(
      (failure) => emit(CoursesError(failure.errMessage)),
      (_) => getCourses(),
    );
  }

  Future<void> updateProgress(String courseId, String uid, int lessonNumber) async {
    emit(CoursesLoading());
    final result = await coursesRepo.updateProgress(courseId, uid, lessonNumber);
    result.fold(
      (failure) => emit(CoursesError(failure.errMessage)),
      (_) => getCourses(),
    );
  }
}
