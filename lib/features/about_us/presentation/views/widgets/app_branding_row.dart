import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/about_us/presentation/views/widgets/app_icon_placeholder.dart';

class AppBrandingRow extends StatelessWidget {
  const AppBrandingRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const AppIconPlaceholder(),
        Gap(12.w),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Monument", style: AppStyles.textStyle32),
            Text(
              "Build better. One day at a time.",
              style: AppStyles.textStyle14.copyWith(
                height: 1,
                color: AppColors.secondaryColor.withValues(alpha: .5),
                fontWeight: FontWeight.bold,
                fontFamily: "klasik",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
