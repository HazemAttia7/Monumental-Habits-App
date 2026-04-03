import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';

class VersionBadge extends StatelessWidget {
  const VersionBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.sp),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(9999.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, color: AppColors.primaryColor, size: 12.sp),
          Gap(4.w),
          Text(
            "Version 1.0.0",
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.secondaryColor,
              fontFamily: "klasik",
              letterSpacing: .55,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Gap(4.w),
          Icon(
            Icons.circle,
            color: AppColors.secondaryColor.withValues(alpha: .3),
            size: 6.sp,
          ),
          Gap(4.w),
          Text(
            "Designed by Pixel True",
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.secondaryColor,
              fontFamily: "klasik",
              letterSpacing: .55,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
