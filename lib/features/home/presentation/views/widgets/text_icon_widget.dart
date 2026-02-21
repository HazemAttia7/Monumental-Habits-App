import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class TextIconWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final double? size, fontSize;
  final VoidCallback onTap;
  const TextIconWidget({
    super.key,
    required this.text,
    required this.icon,
    required this.color,
    this.size,
    this.fontSize,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10.r),
        onTap: onTap,
        child: Row(
          children: [
            Text(
              text,
              style: AppStyles.textStyle16.copyWith(
                fontSize: fontSize,
                color: color,
              ),
            ),
            Gap(5.w),
            Icon(icon, color: color, size: size ?? 18.sp),
          ],
        ),
      ),
    );
  }
}
