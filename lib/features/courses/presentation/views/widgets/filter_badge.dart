import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';

class FilterBadge extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;
  const FilterBadge({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected
          ? AppColors.secondaryColor.withValues(alpha: .1)
          : Colors.white,
      borderRadius: BorderRadius.circular(9999.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(9999.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.sp,
              color: isSelected
                  ? AppColors.secondaryColor
                  : AppColors.secondaryColor.withValues(alpha: .3),
            ),
            borderRadius: BorderRadius.circular(9999.r),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: .55,
            ),
          ),
        ),
      ),
    );
  }
}
