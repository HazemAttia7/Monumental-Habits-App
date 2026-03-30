import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/features/habits_hsitory/presentation/managers/habits_history_view_controller.dart';
import 'package:pixel_true_app/features/habits_hsitory/presentation/views/widgets/habits_history_filter_chips.dart';
import 'package:pixel_true_app/features/habits_hsitory/presentation/views/widgets/habits_history_sliver_list.dart';
import 'package:pixel_true_app/core/widgets/default_view_header.dart';
import 'package:provider/provider.dart';

class HabitsHistoryViewBody extends StatelessWidget {
  const HabitsHistoryViewBody({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<HabitsHistoryController>();
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
                  Gap(12.h),
                  HabitsHistoryFilterChips(
                    status: controller.status,
                    onStatusChanged: controller.onStatusChanged,
                  ),
                  Gap(18.h),
                ],
              ),
            ),
            HabitsHistorySliverList(status: controller.status),
            SliverToBoxAdapter(child: Gap(24.h)),
          ],
        ),
      ),
    );
  }
}
