import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class TextIconWidget extends StatelessWidget {
  const TextIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Custom",
          style: AppStyles.textStyle16.copyWith(
            color: AppColors.secondaryColor,
          ),
        ),
        Gap(5.w),
        Icon(
          FontAwesomeIcons.chevronRight,
          color: AppColors.secondaryColor,
          size: 18.sp,
        ),
      ],
    );
  }
}
