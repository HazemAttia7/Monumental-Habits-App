import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/custom_search_field.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/habits_analytics_sliver_list.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/profile_habits_analytics_header.dart';

class ProfileHabitsAnalyticsViewBody extends StatefulWidget {
  const ProfileHabitsAnalyticsViewBody({super.key});

  @override
  State<ProfileHabitsAnalyticsViewBody> createState() =>
      _ProfileHabitsAnalyticsViewBodyState();
}

class _ProfileHabitsAnalyticsViewBodyState
    extends State<ProfileHabitsAnalyticsViewBody> {
  String _query = '';
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
                    onChanged: (value) => setState(() => _query = value),
                  ),
                  Gap(24.h),
                ],
              ),
            ),
            HabitsAnalyticsSliverList(query: _query),
            SliverToBoxAdapter(child: Gap(24.h)),
          ],
        ),
      ),
    );
  }
}
