import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/utils/assets_data.dart';
import 'package:pixel_true_app/features/subscription/presentation/views/widgets/countdown_from_date.dart';

class OfferWidget extends StatelessWidget {
  const OfferWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.r),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Stack(
          children: [
            Positioned(
              top: -42.sp,
              right: -85.sp,
              child: Image.asset(AssetsData.teepeeSwirly, width: 260.w),
            ),
            Container(
              padding: EdgeInsets.all(24.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "60% off your upgrade",
                    style: AppStyles.textStyle20.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Gap(12.h),
                  Text(
                    "Expires in",
                    style: AppStyles.textStyle12.copyWith(
                      color: AppColors.secondaryColor.withValues(alpha: .5),
                    ),
                  ),
                  Gap(8.h),
                  CountdownFromDate(
                    endTime: DateTime(
                      2026,
                      4,
                      2,
                      20,
                    ).add(const Duration(hours: 3)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
