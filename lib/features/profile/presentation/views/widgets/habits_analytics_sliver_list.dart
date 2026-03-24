import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/habits_analytics_sliver_list_item.dart';

class HabitsAnalyticsSliverList extends StatelessWidget {
  const HabitsAnalyticsSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: 10,
      itemBuilder: (context, index) => const HabitsAnalyticsSliverListItem(),
      separatorBuilder: (BuildContext context, int index) => Gap(16.h),
    );
  }
}
