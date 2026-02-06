import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';

class CurrentDayBadge extends StatelessWidget {
  const CurrentDayBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3,
      width: 16.sp,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(1000.r),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            color: AppColors.primaryColor.withValues(alpha: .5),
            spreadRadius: 0,
            blurRadius: 6,
          ),
        ],
      ),
    );
  }
}
