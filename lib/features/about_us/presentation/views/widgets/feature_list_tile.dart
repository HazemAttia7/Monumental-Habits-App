import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/icon_container.dart';

class FeatureListTile extends StatelessWidget {
  final String title, subtitle;
  final IconData icon;
  const FeatureListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8.w,
      children: [
        IconContainer(
          icon: icon,
          iconSize: 28.sp,
          padding: EdgeInsets.all(6.sp),
          iconColor: AppColors.primaryColor,
          backColor: AppColors.primaryColor.withValues(alpha: .1),
          borderRadius: BorderRadius.circular(12.r),
        ),
        Expanded(
          child: Column(
            spacing: 4.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppStyles.textStyle16.copyWith(color: Colors.black),
              ),
              Text(
                subtitle,
                style: AppStyles.textStyle12.copyWith(
                  color: AppColors.secondaryColor.withValues(alpha: .7),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
