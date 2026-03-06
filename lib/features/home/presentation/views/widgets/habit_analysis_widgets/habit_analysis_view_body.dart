import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/features/home/data/models/habit_model.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/habit_analysis_widgets/calendar_widget.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/habit_analysis_widgets/habit_analysis_header.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/habit_analysis_widgets/habit_summary_widget.dart';

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
              child: const HabitAnalysisHeader(),
            ),
            Gap(24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kPagePadding.sp),
              child: HabitSummaryWidget(habit: habit, themeColor: themeColor),
            ),
            Gap(16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kPagePadding.sp),
              child: CalendarWidget(themeColor: themeColor),
            ),
            Gap(46.h),
          ],
        ),
      ),
    );
  }
}
