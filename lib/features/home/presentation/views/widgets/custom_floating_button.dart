import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/monumental_habits_icons.dart';

class CustomFloatingButton extends StatelessWidget {
  final VoidCallback onTap;
  const CustomFloatingButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(6.sp),
        width: 64.sp,
        foregroundDecoration: BoxDecoration(
          color: AppColors.morning.withValues(alpha: .2),
          shape: BoxShape.circle,
        ),
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.morning,
            shape: BoxShape.circle,
          ),
          child: Center(child: Icon(MonumentalHabitsIcons.plus, size: 18.sp)),
        ),
      ),
    );
  }
}
