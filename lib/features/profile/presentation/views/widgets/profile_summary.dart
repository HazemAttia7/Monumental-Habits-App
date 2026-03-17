import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/profile_analytics_row.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/user_info_row.dart';

class ProfileSummary extends StatelessWidget {
  const ProfileSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: const UserInfoRow(),
          ),
          Gap(12.h),
          const Divider(color: AppColors.scaffoldColor),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: ProfileAnalyticsRow(),
          ),
        ],
      ),
    );
  }
}
