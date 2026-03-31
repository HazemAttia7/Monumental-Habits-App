import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class DiscountBadge extends StatelessWidget {
  const DiscountBadge({super.key, required this.discountPercentage});

  final int discountPercentage;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -3.14 / 4,
      child: Container(
        padding: EdgeInsets.only(top: 1.h),
        width: 120.w,
        height: 50.h,
        decoration: const BoxDecoration(color: AppColors.primaryColor),
        child: Text(
          "-$discountPercentage%",
          textAlign: TextAlign.center,
          style: AppStyles.textStyle10.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
