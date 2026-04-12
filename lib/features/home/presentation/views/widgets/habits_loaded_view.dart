import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/managers/home_view_controller.dart';
import 'package:pixel_true_app/core/utils/assets_data.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/features/home/data/models/habit_model.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/habits_section_header.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/habits_tracking_sliver_list.dart';
import 'package:pixel_true_app/core/widgets/view_header.dart';
import 'package:provider/provider.dart';

class HabitsLoadedView extends StatelessWidget {
  const HabitsLoadedView({super.key, required this.habits});

  final List<Habit> habits;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<HomeViewController>();
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
                  child: const ViewHeader(header: "Home Page"),
                ),
                Gap(24.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: kPagePadding.sp),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.asset(
                      AssetsData.quoteImage,
                      height: 140.h,
                      fit: BoxFit.cover,
                    ),
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
              habitsList: habits,
            ),
          ),
        ],
      ),
    );
  }
}
