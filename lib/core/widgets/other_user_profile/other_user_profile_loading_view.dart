import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/widgets/default_view_header.dart';
import 'package:pixel_true_app/core/widgets/other_user_profile/shimmer/add_friend_button_shimmer.dart';
import 'package:pixel_true_app/core/widgets/other_user_profile/shimmer/orher_user_habit_analytics_list_shimmer.dart';
import 'package:pixel_true_app/core/widgets/other_user_profile/shimmer/other_user_profile_summary_shimmer.dart';

class OtherUserProfileLoadingView extends StatelessWidget {
  const OtherUserProfileLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          Gap(10.h),
          const DefaultViewHeader(title: "user's Profile"),
          Gap(24.h),
          const AddFriendButtonShimmer(),
          Gap(16.h),
          const OtherUserProfileSummaryShimmer(),
          Gap(16.h),
          const OrherUserHabitAnalyticsListShimmer(),
        ],
      ),
    );
  }
}
