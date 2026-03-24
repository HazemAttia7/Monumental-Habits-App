import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class StatCard extends StatelessWidget {
  final String title, subtitle;
  final int value;
  final bool isDisabled;
  const StatCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        color: isDisabled
            ? AppColors.secondaryColor.withValues(alpha: .08)
            : AppColors.primaryColor.withValues(alpha: .15),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title.toUpperCase(),
            style: AppStyles.textStyle12.copyWith(
              color: isDisabled
                  ? AppColors.secondaryColor.withValues(alpha: .3)
                  : AppColors.primaryColor,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
              height: 1,
              letterSpacing: .96,
            ),
          ),
          Gap(4.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isDisabled ? "--" : value.toString(),
                style: AppStyles.textStyle18.copyWith(
                  fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                  color: isDisabled
                      ? AppColors.secondaryColor.withValues(alpha: .3)
                      : null,
                ),
              ),
              Gap(4.w),
              Text(
                subtitle.toLowerCase(),
                style: AppStyles.textStyle14.copyWith(
                  color: isDisabled
                      ? AppColors.secondaryColor.withValues(alpha: .3)
                      : AppColors.primaryColor,
                  fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                  height: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
