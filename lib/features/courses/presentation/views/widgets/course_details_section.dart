import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/save_course_button.dart';

class CourseDetailsSection extends StatelessWidget {
  const CourseDetailsSection({
    super.key,
    required this.title,
    required this.duration,
    required this.lessons,
    required this.onSave,
    required this.onUnsave,
  });

  final String title;
  final Duration duration;
  final int lessons;
  final VoidCallback onSave;
  final VoidCallback onUnsave;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12.r),
          bottomRight: Radius.circular(12.r),
        ),
      ),
      child: Column(
        children: [
          Text(title, style: AppStyles.textStyle18),
          Gap(8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getDurationText(duration),
                      style: AppStyles.textStyle12,
                    ),
                    Text(
                      _getLessonsText(lessons),
                      style: AppStyles.textStyle12.copyWith(
                        color: AppColors.secondaryColor.withValues(alpha: .5),
                      ),
                    ),
                  ],
                ),
                SaveCourseButton(onSave: onSave, onUnsave: onUnsave),
              ],
            ),
          ),
          Gap(2.h),
        ],
      ),
    );
  }

  String _getDurationText(Duration duration) {
    return "${duration.inHours}h ${duration.inMinutes.remainder(60)}m";
  }

  String _getLessonsText(int lessons) {
    if (lessons == 1) return "$lessons Lesson";
    return "$lessons Lessons";
  }
}
