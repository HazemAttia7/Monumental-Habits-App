import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/icon_container.dart';

class AnalyticsWidget extends StatelessWidget {
  final String title, subtitle;
  final IconData icon;
  final Color iconColor;
  final double? iconSize;
  final EdgeInsets? padding;
  const AnalyticsWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    this.iconSize,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppStyles.textStyle24.copyWith(
                  fontFamily: "Klasik",
                  height: 1,
                ),
              ),
              Gap(4.h),
              Text(
                subtitle,
                style: AppStyles.textStyle12.copyWith(
                  color: AppColors.secondaryColor.withValues(alpha: .5),
                  height: 1,
                ),
                maxLines: 2,
              ),
            ],
          ),
        ),
        IconContainer(
          icon: icon,
          iconColor: iconColor,
          iconSize: iconSize,
          padding: padding,
        ),
      ],
    );
  }
}
