import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/widgets/other_user_profile/shimmer/other_user_habits_completed_section_shimmer.dart';
import 'package:pixel_true_app/core/widgets/other_user_profile/shimmer/other_user_profile_analytics_row_shimmer.dart';
import 'package:pixel_true_app/core/widgets/other_user_profile/shimmer/user_meta_info_row_shimmer.dart';

class OtherUserProfileSummaryShimmer extends StatelessWidget {
  const OtherUserProfileSummaryShimmer({super.key});

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
          const UserMetaInfoRowShimmer(),
          Gap(12.h),
          const OtherUserProfileAnalyticsRowShimmer(),
          Gap(8.h),
          const OtherUserHabitsCompletedSectionShimmer(),
        ],
      ),
    );
  }
}
