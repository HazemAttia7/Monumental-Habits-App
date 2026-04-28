import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class OptionWidget extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? backColor;
  const OptionWidget({
    super.key,
    required this.text,
    required this.onTap,
    this.backColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      color: backColor ?? Color.lerp(AppColors.primaryColor, Colors.white, 0.1),
      child: Center(
        child: Text(
          text,
          style: AppStyles.textStyle14.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
