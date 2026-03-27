import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/features/habits_hsitory/presentation/views/widgets/habits_history_sliver_list.dart';
import 'package:pixel_true_app/core/widgets/default_view_header.dart';

class HabitsHistoryViewBody extends StatefulWidget {
  const HabitsHistoryViewBody({super.key});

  @override
  State<HabitsHistoryViewBody> createState() => _HabitsHistoryViewBodyState();
}

class _HabitsHistoryViewBodyState extends State<HabitsHistoryViewBody> {
  String _status = 'all';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kPagePadding.w),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Gap(12.h),
                  const DefaultViewHeader(title: 'Habits History'),
                  Gap(24.h),
                  // TODO : filter by completion using status string
                  Gap(24.h),
                ],
              ),
            ),
            HabitsHistorySliverList(status: _status),
            SliverToBoxAdapter(child: Gap(24.h)),
          ],
        ),
      ),
    );
  }
}
