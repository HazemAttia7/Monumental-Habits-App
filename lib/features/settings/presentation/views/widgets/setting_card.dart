import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/icon_container.dart';

class SettingCard extends StatelessWidget {
  final String title, subtitle;
  final IconData icon;
  final VoidCallback onTap;
  const SettingCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        splashColor: AppColors.primaryColor.withValues(alpha: .1),
        highlightColor: AppColors.primaryColor.withValues(alpha: .1),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
          child: Row(
            children: [
              IconContainer(
                padding: EdgeInsets.all(8.sp),
                icon: icon,
                iconColor: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(12.r),
                iconSize: 24.sp,
              ),
              Gap(12.w),
              _TextSection(title: title, subtitle: subtitle),
              const Spacer(),
              Icon(
                FontAwesomeIcons.angleRight,
                color: AppColors.secondaryColor,
                size: 18.sp,
                shadows: [
                  Shadow(
                    color: AppColors.secondaryColor.withValues(alpha: .5),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TextSection extends StatelessWidget {
  const _TextSection({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppStyles.textStyle16.copyWith(fontWeight: FontWeight.w500),
        ),
        Text(
          subtitle,
          style: AppStyles.textStyle14.copyWith(
            color: AppColors.secondaryColor.withValues(alpha: .5),
          ),
        ),
      ],
    );
  }
}
