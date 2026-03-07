import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/features/home/data/models/habit_model.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/habit_analysis_widgets/habit_image_placeholder.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/habit_analysis_widgets/summary_column.dart';

class HabitSummarySection extends StatelessWidget {
  final Habit habit;
  final Color themeColor;
  const HabitSummarySection({
    super.key,
    required this.habit,
    required this.themeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          HabitImagePlaceholder(themeColor: themeColor),
          Gap(20.w),
          Expanded(
            child: SummaryColumn(habit: habit, themeColor: themeColor),
          ),
        ],
      ),
    );
  }
}
