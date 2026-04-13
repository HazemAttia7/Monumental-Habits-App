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
    if (isClosed) return;
    emit(CoursesLoading());

    final coursesResult = await coursesRepo.getCourses();
    final savedResult = await coursesRepo.getSavedCourseIds(uid);

    if (isClosed) return;
    coursesResult.fold(
      (failure) {
        if (!isClosed) emit(CoursesError(failure.errMessage));
      },
      (courses) async {
        final savedIds = savedResult.fold(
          (failure) => <String>{},
          (savedResult) => savedResult,
        );

        final validCourses = courses
            .where((course) => course.id != null)
            .toList();
        final lastWatchedResults = await Future.wait(
          validCourses.map(
            (course) => coursesRepo.getLastWatchedLesson(course.id!, uid),
          ),
        );
        if (isClosed) return;

        final updatedCourses = validCourses.asMap().entries.map((entry) {
          final i = entry.key;
          final course = entry.value;

          final lastWatched = lastWatchedResults[i].fold(
            (failure) => null,
            (value) => value,
          );
          return course.copyWith(
            isSaved: savedIds.contains(course.id),
            lastWatchedLesson: lastWatched ?? 0,
          );
        }).toList();

        if (!isClosed) emit(CoursesLoaded(updatedCourses));
      },
    );
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
      (failure) {
        emit(CoursesLoaded(currentCourses));
        emit(CoursesError(failure.errMessage));
      },
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

    final currentCourse = currentCourses[index];
    final currentLesson = currentCourse.lastWatchedLesson;

    // ✅ Prevent downgrade (only move forward)
    final updatedLesson = lessonNumber > currentLesson
        ? lessonNumber
        : currentLesson;

    // 1. Optimistic update
    final optimisticCourses = List<Course>.from(currentCourses);
    optimisticCourses[index] = currentCourse.copyWith(
      lastWatchedLesson: updatedLesson,
    );

    emit(CoursesLoaded(optimisticCourses));

    // 2. Persist to Firestore
    final result = await coursesRepo.updateProgress(
      courseId,
      uid,
      updatedLesson,
    );

    // 3. Revert on failure
    result.fold(
      (failure) {
        emit(CoursesLoaded(currentCourses));
        emit(CoursesError(failure.errMessage));
      },
      (_) => null, // already emitted optimistically
    );
  }
}
