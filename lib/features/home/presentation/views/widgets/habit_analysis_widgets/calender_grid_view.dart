import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/enums/habit_enums.dart';
import 'package:pixel_true_app/core/widgets/animated_snack_bar.dart';
import 'package:pixel_true_app/features/home/data/models/habit_model.dart';
import 'package:pixel_true_app/core/managers/cubits/habits_cubit/habits_cubit.dart';
import 'package:pixel_true_app/core/managers/habit_analysis_view_controller.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/habit_analysis_widgets/calender_grid_view_item.dart';

class CalendarGridView extends StatelessWidget {
  final Habit habit;
  final Color themeColor;

  const CalendarGridView({
    super.key,
    required this.habit,
    required this.themeColor,
  });

  Color get _mutedColor => HSLColor.fromColor(
    themeColor,
  ).withSaturation(0).withLightness(0.75).toColor();

  @override
  Widget build(BuildContext context) {
    final controller = context.read<HabitAnalysisViewController>();

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 47 / 82,
        mainAxisSpacing: 8.sp,
        crossAxisSpacing: 6.sp,
      ),
      itemCount: controller.gridSize,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) {
        // ── Next-month padding ──
        if (index > controller.totalCells - 1) {
          return _buildDisabledItem(
            index - controller.totalCells + 1,
            enHabitDailyStatus.none,
          );
        }

        // ── Prev-month padding ──
        if (index < controller.startOffset) {
          final day =
              controller.prevMonthDays - controller.startOffset + index + 1;
          final dateKey = HabitAnalysisViewController.formatDateKey(
            controller.prevYear,
            controller.prevMonth,
            day,
          );
          final state = habit.logs[dateKey] ?? enHabitDailyStatus.none;
          return _buildDisabledItem(day, state);
        }

        // ── Current-month day ──
        final day = index - controller.startOffset + 1;
        final date = DateTime(
          controller.currentDate.year,
          controller.currentDate.month,
          day,
        );
        final dateKey = HabitAnalysisViewController.formatDateKey(
          controller.currentDate.year,
          controller.currentDate.month,
          day,
        );
        final state = habit.logs[dateKey] ?? enHabitDailyStatus.none;

        return CalenderGridViewItem(
          themeColor: themeColor,
          number: day,
          habitCompletionState: state,
          isActive: true,
          onTap: () => _onDayTap(context, controller, date),
        );
      },
    );
  }

  void _onDayTap(
    BuildContext context,
    HabitAnalysisViewController controller,
    DateTime date,
  ) {
    final error = controller.validateDayTap(habit: habit, date: date);
    if (error != null) {
      buildClosableSnackBar(context, message: error);
      return;
    }
    context.read<HabitsCubit>().cycleHabitStatus(habit.id, date);
  }

  CalenderGridViewItem _buildDisabledItem(
    int number,
    enHabitDailyStatus state,
  ) {
    return CalenderGridViewItem(
      themeColor: _mutedColor,
      number: number,
      habitCompletionState: state,
      isActive: false,
    );
  }
}
