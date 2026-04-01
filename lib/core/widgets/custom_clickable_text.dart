import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';

class CustomClickableText extends StatelessWidget {
  final String text;
  final void Function() onTap;
  final Color? textColor;
  final double? fontSize;
  final TextDecoration? textDecoration;
  const CustomClickableText({
    super.key,
    required this.text,
    required this.onTap,
    this.textColor,
    this.fontSize,
    this.textDecoration,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: onTap,
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize ?? 17.sp,
            color: textColor ?? AppColors.primaryColor,
            fontWeight: FontWeight.bold,
            decoration: textDecoration,
            decorationColor: textColor ?? AppColors.primaryColor,
            decorationThickness: 3.sp,
          ),
        ),
      ),
    );
  }
}
