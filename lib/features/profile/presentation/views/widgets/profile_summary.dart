import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/features/profile/presentation/managers/profile_controller.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/habits_completed_section.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/profile_analytics_row.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/user_info_row.dart';
import 'package:provider/provider.dart';

class ProfileSummary extends StatelessWidget {
  const ProfileSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ProfileController>();
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
            child: UserInfoRow(onDropdownChanged: controller.setFilterBy),
          ),
          Gap(12.h),
          const ProfileAnalyticsRow(),
          Gap(8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: HabitsCompletedSection(value: controller.filterBy),
          ),
        ],
      ),
    );
  }
}
