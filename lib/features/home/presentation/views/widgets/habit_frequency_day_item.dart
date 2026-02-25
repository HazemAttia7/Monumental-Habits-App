import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class HabitFrequencyDayItem extends StatelessWidget {
  final bool showBorder;
  final String day;
  const HabitFrequencyDayItem({
    super.key,
    this.showBorder = true,
    required this.day,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
      decoration: BoxDecoration(
        border: showBorder
            ? Border(
                right: BorderSide(width: 1.sp, color: const Color(0xffFFF3E9)),
              )
            : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            day.toUpperCase(),
            style: AppStyles.textStyle10.copyWith(
              color: AppColors.primaryColor.withValues(alpha: 0.5),
            ),
          ),
          Container(
            width: 34.sp,
            height: 34.sp,
            decoration: BoxDecoration(
              color: AppColors.morning,
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        ],
      ),
    );
  }
}
