import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/enums/subscription_enums.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class PlanCard extends StatelessWidget {
  final bool isSelected;
  final enPlanType planType;
  final double price;
  const PlanCard({
    super.key,
    required this.isSelected,
    required this.planType,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.fastOutSlowIn,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: isSelected
            ? Border.all(color: AppColors.primaryColor, width: 2.w)
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (planType == enPlanType.yearly)
            Container(
              padding: EdgeInsets.symmetric(vertical: 6.h),
              color: AppColors.primaryColor,
              child: Center(
                child: Text(
                  "Most Popular",
                  style: AppStyles.textStyle12.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          Gap(4.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Text(
              "\$${price.toStringAsFixed(2)}",
              style: AppStyles.textStyle20.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
          ),
          Gap(6.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Text(
              "access plan for ${price.toStringAsFixed(2)} USD",
              textAlign: TextAlign.center,
              style: AppStyles.textStyle10.copyWith(
                color: AppColors.secondaryColor.withValues(alpha: .5),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Gap(4.h),
          Divider(color: AppColors.primaryColor.withValues(alpha: .2)),
          Gap(4.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Text(
              _getPlanType(planType),
              style: AppStyles.textStyle12.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Gap(8.h),
        ],
      ),
    );
  }

  String _getPlanType(enPlanType planType) {
    switch (planType) {
      case enPlanType.monthly:
        return "Monthly";
      case enPlanType.yearly:
        return "Yearly";
      case enPlanType.lifetime:
        return "Lifetime";
    }
  }
}
