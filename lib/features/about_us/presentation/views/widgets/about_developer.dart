import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/about_us/presentation/views/widgets/custom_badge.dart';

class AboutDeveloper extends StatelessWidget {
  const AboutDeveloper({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 60.w,
          height: 60.h,
          padding: EdgeInsets.all(11.sp),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.secondaryColor,
          ),
          child: Center(
            child: Text(
              "H",
              style: AppStyles.textStyle24.copyWith(color: Colors.white),
            ),
          ),
        ),
        Gap(12.w),
        Column(
          spacing: 4.w,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hazem (Solo Dev)",
              style: AppStyles.textStyle16.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              spacing: 6.w,
              children: [
                Text(
                  "Developer",
                  style: AppStyles.textStyle14.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondaryColor.withValues(alpha: .5),
                  ),
                ),
                const _DotDivider(),
                Text(
                  "Designer",
                  style: AppStyles.textStyle14.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondaryColor.withValues(alpha: .5),
                  ),
                ),
                const _DotDivider(),
                Text(
                  "Creative",
                  style: AppStyles.textStyle14.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondaryColor.withValues(alpha: .5),
                  ),
                ),
              ],
            ),
            const CustomBadge(
              title: "100% Solo-built",
              backColor: AppColors.primaryColor,
              textColor: AppColors.primaryColor,
            ),
          ],
        ),
      ],
    );
  }
}

class _DotDivider extends StatelessWidget {
  const _DotDivider();

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.circle,
      color: AppColors.secondaryColor.withValues(alpha: .3),
      size: 6.sp,
    );
  }
}
