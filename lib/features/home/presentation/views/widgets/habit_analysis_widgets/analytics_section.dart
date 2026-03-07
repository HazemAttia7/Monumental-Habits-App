import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/habit_analysis_widgets/analytics_details.dart';

class AnalyticsSection extends StatelessWidget {
  const AnalyticsSection({super.key, required this.themeColor});
  final Color themeColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.sp),
      decoration: BoxDecoration(
        color: Color.lerp(themeColor, Colors.white, 0.9),
        boxShadow: [
          BoxShadow(
            color: Color.lerp(themeColor, Colors.white, 0.75)!,
            blurRadius: 30,
            spreadRadius: 0,
            offset: const Offset(0, -15),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Analytics",
            style: AppStyles.textStyle16.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor.withValues(alpha: .6),
            ),
          ),
          Gap(22.h),
          const AnalyticsDetails(),
        ],
      ),
    );
  }
}
