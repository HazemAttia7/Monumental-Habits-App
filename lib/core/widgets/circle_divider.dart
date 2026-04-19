import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';

class CircleDivider extends StatelessWidget {
  final Color? color;
  const CircleDivider({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.circle,
      color: color ?? AppColors.secondaryColor.withValues(alpha: .3),
      size: 6.sp,
    );
  }
}
