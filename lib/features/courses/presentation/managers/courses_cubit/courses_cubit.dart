import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pixel_true_app/core/enums/courses_enums.dart';
import 'package:pixel_true_app/features/courses/data/models/course_model.dart';
import 'package:pixel_true_app/features/courses/data/repos/courses_repo.dart';

part 'courses_state.dart';

class CoursesCubit extends Cubit<CoursesState> {
  final CoursesRepo coursesRepo;
  CoursesCubit(this.coursesRepo) : super(CoursesInitial());

  Future<void> getCourses(String uid) async {
    emit(CoursesLoading());
    final coursesResult = await coursesRepo.getCourses();
    final savedResult = await coursesRepo.getSavedCourseIds(uid);
    coursesResult.fold((failure) => emit(CoursesError(failure.errMessage)), (
      courses,
    ) {
      final savedIds = savedResult.fold((l) => <String>{}, (r) => r);

      final updatedCourses = courses.map((course) {
        return course.copyWith(isSaved: savedIds.contains(course.id));
      }).toList();

      emit(CoursesLoaded(updatedCourses));
    });
  }

  Future<void> toggleSaveCourse({
    required String courseId,
    required String uid,
  }) async {
    final currentState = state;
    if (currentState is! CoursesLoaded) return;

    // 1. Find the course and its current saved state
    final currentCourses = currentState.courses;
    final index = currentCourses.indexWhere((c) => c.id == courseId);
    if (index == -1) return;

    final course = currentCourses[index];
    final newIsSaved = !course.isSaved;

    // 2. Optimistic emit — update UI immediately
    final optimisticCourses = List<Course>.from(currentCourses);
    optimisticCourses[index] = course.copyWith(isSaved: newIsSaved);
    emit(CoursesLoaded(optimisticCourses));

    // 3. Persist to Firestore
    final result = await coursesRepo.toggleSaveCourse(
      courseId,
      uid,
      course.isSaved,
    );

    // 4. Revert on failure
    result.fold(
      (failure) => emit(
        CoursesError(failure.errMessage, previousCourses: currentCourses),
      ),
      (_) => null, // already emitted optimistically
    );
  }

  Future<void> updateProgress({
    required String courseId,
    required String uid,
    required int lessonNumber,
  }) async {
    final currentState = state;
    if (currentState is! CoursesLoaded) return;

    final currentCourses = currentState.courses;
    final index = currentCourses.indexWhere((c) => c.id == courseId);
    if (index == -1) return;

    // 1. Optimistic emit
    final optimisticCourses = List<Course>.from(currentCourses);
    optimisticCourses[index] = currentCourses[index].copyWith(
      lastWatchedLesson: lessonNumber,
    );
    emit(CoursesLoaded(optimisticCourses));

    // 2. Persist to Firestore
    final result = await coursesRepo.updateProgress(
      courseId,
      uid,
      lessonNumber,
    );

    // 3. Revert on failure
    result.fold(
      (failure) => emit(
        CoursesError(failure.errMessage, previousCourses: currentCourses),
      ),
      (_) => null,
    );
  }
}
