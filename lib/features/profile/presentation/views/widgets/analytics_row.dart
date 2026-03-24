import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class AnalyticsRow extends StatelessWidget {
  const AnalyticsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8.w,
      children: List.generate(
        3,
        (index) => Expanded(
          child: Container(
            padding: EdgeInsets.all(12.sp),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: .15),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Current".toUpperCase(),
                  style: AppStyles.textStyle12.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                    height: 1,
                    letterSpacing: .96,
                  ),
                ),
                Gap(4.h),
                Text(
                  "4",
                  style: AppStyles.textStyle18.copyWith(
                    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
