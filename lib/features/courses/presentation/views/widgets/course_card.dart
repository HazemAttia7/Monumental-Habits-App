import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/utils/assets_data.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/save_course_button.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 166.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.r),
              topRight: Radius.circular(12.r),
            ),
            image: const DecorationImage(
              image: AssetImage(AssetsData.coursePlaceholder),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
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
              Text(
                "30 Day Journal Challenge - Establish a Habit of Daily Journaling",
                style: AppStyles.textStyle18,
              ),
              Gap(8.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("2h 41m", style: AppStyles.textStyle12),
                        Text(
                          "37 Lessons",
                          style: AppStyles.textStyle12.copyWith(
                            color: AppColors.secondaryColor.withValues(
                              alpha: .5,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SaveCourseButton(onSave: () {}, onUnsave: () {}),
                  ],
                ),
              ),
              Gap(2.h),
            ],
          ),
        ),
      ],
    );
  }
}
