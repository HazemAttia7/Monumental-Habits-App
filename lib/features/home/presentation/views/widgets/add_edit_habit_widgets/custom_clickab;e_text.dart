
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class CustomClickableText extends StatelessWidget {
  final String text;
  final void Function() onTap;
  const CustomClickableText({
    super.key, required this.text, required this.onTap,
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
          style: AppStyles.textStyle17.copyWith(
            color: AppColors.secondaryColor,
          ),
        ),
      ),
    );
  }
}
