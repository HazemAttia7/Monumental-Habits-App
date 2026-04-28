import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';

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
    return Material(
      color: backColor ?? Color.lerp(AppColors.primaryColor, Colors.white, 0.1),
      child: InkWell(
        onTap: onTap,
        splashColor: AppColors.secondaryColor.withValues(alpha: .1),
        highlightColor: AppColors.secondaryColor.withValues(alpha: .1),
        child: SizedBox(
          height: 40.h,
          child: Center(
            child: Text(
              text,
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
