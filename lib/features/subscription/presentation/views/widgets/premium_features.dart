import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/subscription/presentation/views/widgets/premium_features_item.dart';

class PremiumFeatures extends StatelessWidget {
  const PremiumFeatures({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 18.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Text("Unlock Monumental Habits", style: AppStyles.textStyle20),
          Gap(12.h),
          Divider(color: AppColors.primaryColor.withValues(alpha: .2)),
          Gap(12.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.sp),
            child: const PremiumFeaturesItem(feature: "Unlimited habits"),
          ),
          Gap(4.h),
          Divider(color: AppColors.primaryColor.withValues(alpha: .2)),
          Gap(4.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.sp),
            child: const PremiumFeaturesItem(feature: "Access to all courses"),
          ),
          Gap(4.h),
          Divider(color: AppColors.primaryColor.withValues(alpha: .2)),
          Gap(4.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.sp),
            child: const PremiumFeaturesItem(
              feature: "Access to all avatar illustrations",
            ),
          ),
        ],
      ),
    );
  }
}
