import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/widgets/other_user_profile/shimmer/habits_analytics_list_item_shimmer.dart';

class OrherUserHabitAnalyticsListShimmer extends StatelessWidget {
  const OrherUserHabitAnalyticsListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 2,
      itemBuilder: (context, index) => const HabitsAnalyticsListItemShimmer(),
      separatorBuilder: (context, index) => Gap(16.h),
    );
  }
}
