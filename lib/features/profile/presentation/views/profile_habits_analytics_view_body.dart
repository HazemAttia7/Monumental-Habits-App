import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/custom_search_field.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/habits_analytics_sliver_list.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/profile_habits_analytics_header.dart';

class ProfileHabitsAnalyticsViewBody extends StatelessWidget {
  const ProfileHabitsAnalyticsViewBody({super.key});

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
                  const ProfileHabitsAnalyticsHeader(),
                  Gap(24.h),
                  CustomSearchField(
                    onChanged: (value) {
                      // TODO : Filter habits after being passed to the view
                    },
                  ),
                  Gap(24.h),
                ],
              ),
            ),
            const HabitsAnalyticsSliverList(),
            SliverToBoxAdapter(child: Gap(24.h)),
          ],
        ),
      ),
    );
  }
}
