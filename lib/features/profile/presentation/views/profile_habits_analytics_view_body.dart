import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/features/profile/presentation/managers/profile_controller.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/custom_search_field.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/habits_analytics_sliver_list.dart';
import 'package:pixel_true_app/core/widgets/default_view_header.dart';
import 'package:provider/provider.dart';

class ProfileHabitsAnalyticsViewBody extends StatelessWidget {
  const ProfileHabitsAnalyticsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ProfileController>();
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
                  const DefaultViewHeader(
                    title: "Habits Analytics",
                    themeColor: AppColors.primaryColor,
                  ),
                  Gap(24.h),
                  CustomSearchField(onChanged: controller.setQuery),
                  Gap(24.h),
                ],
              ),
            ),
            HabitsAnalyticsSliverList(query: controller.query),
            SliverToBoxAdapter(child: Gap(24.h)),
          ],
        ),
      ),
    );
  }
}
