import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/features/courses/helper/get_duration_text.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/courses/data/models/course_model.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/course_details/lesson_details_summary.dart';

class LessonsSection extends StatelessWidget {
  final Course course;
  const LessonsSection({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(12.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(course.title, style: AppStyles.textStyle18),
          ),
          Gap(18.h),
          Divider(
            color: AppColors.primaryColor.withValues(alpha: .1),
            thickness: 2.w,
            height: 1,
          ),
          Gap(12.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              _getLessonsText(course.lessons.length, course.duration),
              style: AppStyles.textStyle16,
            ),
          ),
          Gap(12.h),
          ...List.generate(
            course.lessons.length,
            (index) => Column(
              children: [
                Divider(
                  color: AppColors.primaryColor.withValues(alpha: .1),
                  thickness: 2.w,
                  height: 1,
                ),
                LessonDetailsSummary(
                  lessonNumber: index + 1,
                  lesson: course.lessons[index],
                  isReached: course.lastWatchedLesson >= index + 1,
                  lastWatchedLesson: course.lastWatchedLesson,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getLessonsText(int lessons, Duration duration) {
    if (lessons == 1) return "$lessons Lesson (${getDurationText(duration)})";
    return "$lessons Lessons (${getDurationText(duration)})";
  }
}
