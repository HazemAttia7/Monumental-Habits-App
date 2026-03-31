import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/enums/subscription_enums.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/features/subscription/presentation/views/widgets/discount_badge.dart';
import 'package:pixel_true_app/features/subscription/presentation/views/widgets/plan_card.dart';

class PlanWidget extends StatelessWidget {
  final double price;
  final enPlanType planType;
  final bool isSelected;
  final int discountPercentage;
  final VoidCallback onTap;
  const PlanWidget({
    super.key,
    this.isSelected = false,
    required this.price,
    required this.planType,
    this.discountPercentage = 0,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        splashColor: AppColors.primaryColor.withValues(alpha: .1),
        highlightColor: AppColors.primaryColor.withValues(alpha: .1),
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Stack(
            children: [
              PlanCard(
                isSelected: isSelected,
                planType: planType,
                price: price,
              ),
              if (discountPercentage != 0)
                Positioned(
                  right: -58.w,
                  bottom: -23.h,
                  child: DiscountBadge(discountPercentage: discountPercentage),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
