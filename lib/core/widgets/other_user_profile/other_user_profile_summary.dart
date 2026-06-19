import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/widgets/other_user_profile/other_user_habits_completed_section.dart';
import 'package:pixel_true_app/core/widgets/other_user_profile/other_user_profile_analytics_row.dart';
import 'package:pixel_true_app/features/profile/presentation/managers/profile_view_controller.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/user_info_row.dart';
import 'package:provider/provider.dart';

class OtherUserProfileSummary extends StatelessWidget {
  final String username;
  const OtherUserProfileSummary({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ProfileViewController>();
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
            child: UserInfoRow(
              onDropdownChanged: controller.setFilterBy,
              username: username,
            ),
          ),
          Gap(12.h),
          const OtherUserProfileAnalyticsRow(),
          Gap(8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: OtherUserHabitsCompletedSection(value: controller.filterBy),
          ),
        ],
      ),
    );
  }
}
