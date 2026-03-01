import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class SideMenuClickableText extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const SideMenuClickableText({
    super.key,
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
        onTap: onTap,
        child: Text(
          text.toUpperCase(),
          style: AppStyles.textStyle14.copyWith(
            color: AppColors.primaryColor.withValues(alpha: .4),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
