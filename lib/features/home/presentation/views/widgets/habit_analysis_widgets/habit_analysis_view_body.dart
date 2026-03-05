import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/features/home/data/models/habit_model.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/habit_analysis_widgets/habit_analysis_header.dart';

class HabitAnalysisViewBody extends StatelessWidget {
  final Habit habit;
  const HabitAnalysisViewBody({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Gap(10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kPagePadding.sp),
            child: const HabitAnalysisHeader(),
          ),
          Gap(24.h),
        ],
      ),
    );
  }
}
