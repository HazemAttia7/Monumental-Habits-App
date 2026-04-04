import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class CustomOutlineButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  const CustomOutlineButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        splashColor: AppColors.secondaryColor.withValues(alpha: .1),
        highlightColor: AppColors.secondaryColor.withValues(alpha: .1),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(16.sp),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.sp,
              color: AppColors.secondaryColor.withValues(alpha: .3),
            ),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 4.w,
            children: [
              Icon(icon, color: AppColors.secondaryColor, size: 16.sp),
              Text(
                text,
                style: AppStyles.textStyle16.copyWith(fontFamily: 'Klasik'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
