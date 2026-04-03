import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';

class CustomBadge extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Color? backColor, textColor;
  const CustomBadge({
    super.key,
    required this.title,
    this.subtitle,
    this.backColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.sp),
      decoration: BoxDecoration(
        color:
            backColor?.withValues(alpha: .1) ??
            AppColors.secondaryColor.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(9999.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, color: AppColors.primaryColor, size: 8.sp),
          Gap(4.w),
          Text(
            title,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.bold,
              color: textColor ?? AppColors.secondaryColor,
              letterSpacing: .55,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (subtitle != null) _buildSubtitle(),
        ],
      ),
    );
  }

  Row _buildSubtitle() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Gap(4.w),
        Icon(
          Icons.circle,
          color: AppColors.secondaryColor.withValues(alpha: .3),
          size: 6.sp,
        ),
        Gap(4.w),
        Text(
          subtitle!,
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.bold,
            color: textColor ?? AppColors.secondaryColor,
            letterSpacing: .55,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
