import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/about_us/presentation/views/widgets/about_developer.dart';
import 'package:pixel_true_app/features/about_us/presentation/views/widgets/card_header.dart';

class AppDeveloperCard extends StatelessWidget {
  const AppDeveloperCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CardHeader(text: "THE DEVELOPER"),
          Gap(14.h),
          const AboutDeveloper(),
          Gap(16.h),
          DottedLine(
            direction: Axis.horizontal,
            lineLength: double.infinity,
            lineThickness: 1.sp,
            dashLength: 3.sp,
            dashColor: AppColors.secondaryColor.withValues(alpha: .25),
          ),
          Gap(16.h),
          Text(
            "Built every pixel, every line of code, and every animation you see — alone. This app is a one-person mission to help people build habits that actually stick. No big team. Just pure passion.",
            style: AppStyles.textStyle14.copyWith(
              color: AppColors.secondaryColor.withValues(alpha: .85),
            ),
          ),
        ],
      ),
    );
  }
}
