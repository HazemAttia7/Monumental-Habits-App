import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/icon_container.dart';

class PremiumFeaturesItem extends StatelessWidget {
  final String feature;
  const PremiumFeaturesItem({super.key, required this.feature});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconContainer(
          icon: Icons.check,
          iconColor: AppColors.secondaryColor,
          backColor: AppColors.primaryColor,
          padding: EdgeInsets.all(2.sp),
          iconSize: 16.sp,
        ),
        Gap(12.w),
        Text(
          feature,
          style: AppStyles.textStyle16.copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
