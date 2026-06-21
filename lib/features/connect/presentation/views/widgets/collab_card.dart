import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/about_us/presentation/views/widgets/custom_badge.dart';

class CollabCard extends StatelessWidget {
  const CollabCard({super.key});

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
          Column(
            spacing: 8.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Let's build together", style: AppStyles.textStyle24),
              Text(
                "Open for collaborations and interesting opportunities.",
                style: AppStyles.textStyle14.copyWith(
                  height: 1,
                  color: AppColors.secondaryColor.withValues(alpha: .5),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Gap(12.h),
          const CustomBadge(title: "Available for projects"),
        ],
      ),
    );
  }
}
