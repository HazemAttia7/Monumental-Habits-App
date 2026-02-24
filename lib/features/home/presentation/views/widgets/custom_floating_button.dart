import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/monumental_habits_icons.dart';

class CustomFloatingButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isActive;
  const CustomFloatingButton({
    super.key,
    required this.onTap,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6.sp),
      width: 64.sp,
      height: 64.sp,
      decoration: BoxDecoration(
        color: AppColors.morning.withValues(alpha: .2),
        shape: BoxShape.circle,
      ),
      child: Material(
        color: AppColors.morning,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: Container(
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: Center(
              child: Icon(
                isActive ? FontAwesomeIcons.check : MonumentalHabitsIcons.plus,
                size: isActive ? 24.sp : 18.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
