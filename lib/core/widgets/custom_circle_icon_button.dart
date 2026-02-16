import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';

class CustomCircleIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  const CustomCircleIconButton({
    super.key,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(11.sp),
        foregroundDecoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primaryColor.withValues(alpha: .1),
        ),
        child: Icon(icon, color: AppColors.primaryColor, size: 22.sp),
      ),
    );
  }
}
