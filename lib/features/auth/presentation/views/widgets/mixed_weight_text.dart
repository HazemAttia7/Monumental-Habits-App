import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class MixedWeightText extends StatelessWidget {
  final VoidCallback togglePages;
  final String normalText, boldText;
  const MixedWeightText({
    super.key,
    required this.togglePages,
    required this.normalText,
    required this.boldText,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(6.r),
        onTap: togglePages,
        child: RichText(
          text: TextSpan(
            style: AppStyles.textStyle14.copyWith(
              fontWeight: FontWeight.normal,
              color: AppColors.primaryColor,
            ),
            children: [
              TextSpan(text: "$normalText "),
              TextSpan(
                text: boldText,
                style: AppStyles.textStyle14.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
