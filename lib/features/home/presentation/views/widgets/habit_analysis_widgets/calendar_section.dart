import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/helper/date_helper.dart';
import 'package:pixel_true_app/features/home/data/models/habit_model.dart';
import 'package:pixel_true_app/core/managers/cubits/habits_cubit/habits_cubit.dart';
import 'package:pixel_true_app/core/managers/habit_analysis_view_controller.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/habit_analysis_widgets/calender_grid_view.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/habit_analysis_widgets/month_actions.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/habit_analysis_widgets/week_days_row.dart';

class CalendarSection extends StatelessWidget {
  final Habit habit;
  final Color themeColor;
  const CalendarSection({
    super.key,
    required this.themeColor,
    required this.habit,
  });

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<HabitAnalysisViewController>();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: MonthActions(
              onNextTap: controller.onNextTap,
              onBackTap: controller.onBackTap,
              month: monthName(controller.currentDate.month),
            ),
          ),
          Gap(16.h),
          const WeekDaysRow(),
          Gap(8.h),
          BlocBuilder<HabitsCubit, HabitsState>(
            builder: (context, state) {
              if (state is! HabitsLoaded) return const SizedBox.shrink();
              final loadedHabit = state.habits.firstWhere(
                (h) => h.id == habit.id,
              );
              return CalendarGridView(
                habit: loadedHabit,
                themeColor: themeColor,
              );
            },
          ),
        ],
      ),
    );
  }
}
