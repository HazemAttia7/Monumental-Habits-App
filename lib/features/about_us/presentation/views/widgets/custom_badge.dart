import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';

class CustomBadge extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Color? backColor;
  final Color? textColor;

  const CustomBadge({
    super.key,
    required this.title,
    this.subtitle,
    this.backColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
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
            Flexible(
              child: RichText(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: textColor ?? AppColors.secondaryColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Klasik',
                    letterSpacing: .55,
                  ),
                  children: [
                    TextSpan(text: title),
                    if (subtitle != null) TextSpan(text: ' • $subtitle'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
