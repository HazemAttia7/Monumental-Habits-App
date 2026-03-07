import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/features/home/data/models/habit_model.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/habit_analysis_widgets/analytics_section.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/habit_analysis_widgets/calendar_section.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/habit_analysis_widgets/habit_analysis_header.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/habit_analysis_widgets/habit_summary_section.dart';

class HabitAnalysisViewBody extends StatelessWidget {
  final Habit habit;
  final Color themeColor;
  const HabitAnalysisViewBody({
    super.key,
    required this.habit,
    required this.themeColor,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Gap(10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kPagePadding.sp),
              child:  HabitAnalysisHeader(themeColor : themeColor),
            ),
            Gap(24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kPagePadding.sp),
              child: HabitSummarySection(habit: habit, themeColor: themeColor),
            ),
            Gap(16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kPagePadding.sp),
              child: CalendarSection(themeColor: themeColor),
            ),
            Gap(46.h),
            AnalyticsSection(themeColor: themeColor),
          ],
        ),
      ),
    );
  }
}
