import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color? backColor, textColor;
  const CustomTextButton({
    super.key,
    required this.onTap,
    required this.text,
    this.backColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(11.sp),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backColor ?? AppColors.primaryColor.withValues(alpha: .1),
        ),
        child: Text(
          text,
          style: AppStyles.textStyle16.copyWith(
            color: textColor ?? AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
