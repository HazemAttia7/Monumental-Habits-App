import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';

class CustomCircleIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final double? iconSize;
  final EdgeInsetsGeometry? padding;
  const CustomCircleIconButton({
    super.key,
    required this.onTap,
    required this.icon,
    this.iconSize,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(9999.r),
      onTap: onTap,
      child: Container(
        padding: padding ?? EdgeInsets.all(11.sp),
        foregroundDecoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primaryColor.withValues(alpha: .1),
        ),
        child: Icon(
          icon,
          color: AppColors.primaryColor,
          size: iconSize ?? 22.sp,
        ),
      ),
    );
  }
}
