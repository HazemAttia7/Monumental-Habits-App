import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/icon_container.dart';
import 'package:pixel_true_app/features/courses/data/models/lesson_model.dart';
import 'package:pixel_true_app/features/courses/presentation/managers/course_details_view_controller.dart';
import 'package:provider/provider.dart';

class LessonDetailsSummary extends StatelessWidget {
  final Lesson lesson;
  final int lessonNumber;
  final bool isReached;
  final int lastWatchedLesson;
  const LessonDetailsSummary({
    super.key,
    required this.lesson,
    required this.lessonNumber,
    this.isReached = false,
    required this.lastWatchedLesson,
  });

  @override
  Widget build(BuildContext context) {
    final controller = context.read<CourseDetailsViewController>();
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => controller.onLessonTap(context, lessonNumber, isReached),
        splashColor: AppColors.primaryColor.withValues(alpha: .1),
        highlightColor: AppColors.primaryColor.withValues(alpha: .1),
        child: Padding(
          padding: EdgeInsets.all(6.sp),
          child: Row(
            children: [
              IconContainer(
                padding: EdgeInsets.all(10.sp),
                icon: isReached ? FontAwesomeIcons.play : FontAwesomeIcons.lock,
                iconColor: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(12.r),
                iconSize: 20.sp,
              ),
              Gap(10.w),
              Expanded(
                child: Text(
                  "$lessonNumber. ${lesson.title}",
                  style: AppStyles.textStyle16.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Gap(10.w),
              Text(
                _getDurationText(lesson.duration),
                style: AppStyles.textStyle16.copyWith(
                  color: AppColors.secondaryColor.withValues(alpha: .5),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Gap(10.w),
            ],
          ),
        ),
      ),
    );
  }

  String _getDurationText(Duration duration) =>
      "${duration.inMinutes}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}";
}
