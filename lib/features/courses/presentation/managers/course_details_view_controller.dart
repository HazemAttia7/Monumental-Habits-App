import 'package:flutter/material.dart';
import 'package:pixel_true_app/core/helper/build_not_implemented_yet_dialog.dart';
import 'package:pixel_true_app/features/courses/data/models/course_model.dart';
import 'package:pixel_true_app/features/courses/presentation/managers/courses_cubit/courses_cubit.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/course_details/unlock_confirmation_dialog.dart';
import 'package:provider/provider.dart';

class CourseDetailsViewController extends ChangeNotifier {
  final String courseId;
  late CoursesCubit _coursesCubit;
  late String _uid;

  CourseDetailsViewController({required this.courseId});

  void init(CoursesCubit cubit, String uid) {
    _coursesCubit = cubit;
    _uid = uid;
  }

  void onVideoTap(BuildContext context) {
    // play leeson using cdn
    buildNotImplementedYetDialog(context, featureName: 'Video Player');
  }

  Course _currentCourse() {
    final state = _coursesCubit.state;
    if (state is CoursesLoaded) {
      return state.courses.firstWhere((c) => c.id == courseId);
    }
    throw Exception('Courses not loaded');
  }

  void onLessonTap(BuildContext context, int lessonNumber, bool isReached) {
    {
      if (!isReached) {
        final course = _currentCourse();
        showDialog(
          context: context,
          builder: (context) => ChangeNotifierProvider.value(
            value: this,
            child: UnlockConfirmationDialog(
              lessonNumber: lessonNumber,
              lastWatchedLesson: course.lastWatchedLesson,
            ),
          ),
        );
      } else {
        buildNotImplementedYetDialog(context, featureName: 'Video Player');
      }
    }
  }

  void onUnlockTap(BuildContext context, int lessonNumber) {
    _coursesCubit.updateProgress(
      courseId: courseId,
      uid: _uid,
      lessonNumber: lessonNumber,
    );
    Navigator.pop(context);
  }
}
