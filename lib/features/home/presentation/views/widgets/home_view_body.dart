import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/assets_data.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/features/home/presentation/managers/home_controller.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/habits_section_header.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/habits_tracking_sliver_list.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/home_header.dart';
import 'package:provider/provider.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<HomeController>();
    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Gap(10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: kPagePadding.sp),
                  child: const HomeHeader(),
                ),
                Gap(24.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: kPagePadding.sp),
                  child: Image.asset(
                    AssetsData.quoteImage,
                    width: double.infinity,
                  ),
                ),
                Gap(19.h),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: (kPagePadding + 18).sp),
              child: HabitsSectionHeader(
                onDayTap: controller.scrollHabitsToDay,
                weekDaysController: controller.weekDaysController,
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(
              left: kPagePadding.sp,
              top: 13.h,
              bottom: 140.sp,
            ),
            sliver: HabitsTrackingSliverList(
              scrollControllers: controller.habitControllers,
            ),
          ),
        ],
      ),
    );
  }
}
