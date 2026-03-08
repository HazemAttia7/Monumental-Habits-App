import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/enums/habit_enums.dart';
import 'package:pixel_true_app/core/widgets/closable_snack_bar.dart';
import 'package:pixel_true_app/features/home/data/models/habit_model.dart';
import 'package:pixel_true_app/features/home/presentation/managers/cubits/home_cubit/home_cubit.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/habit_analysis_widgets/calender_grid_view_item.dart';

class CalendarGridView extends StatelessWidget {
  final Habit habit;
  final Color themeColor;
  final DateTime currentDate;

  const CalendarGridView({
    super.key,
    required this.habit,
    required this.themeColor,
    required this.currentDate,
  });

  String _formatDateKey(int y, int m, int d) =>
      '$y-${m.toString().padLeft(2, '0')}-${d.toString().padLeft(2, '0')}';

  Color get _mutedThemeColor => HSLColor.fromColor(
    themeColor,
  ).withSaturation(0).withLightness(0.75).toColor();

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final firstDay = DateTime(currentDate.year, currentDate.month, 1);
    final daysInMonth = DateTime(
      currentDate.year,
      currentDate.month + 1,
      0,
    ).day;
    final prevMonthDays = DateTime(currentDate.year, currentDate.month, 0).day;
    final startOffset = firstDay.weekday == 7 ? 0 : firstDay.weekday;
    final totalCells = startOffset + daysInMonth;

    final prevMonth = currentDate.month == 1 ? 12 : currentDate.month - 1;
    final prevYear = currentDate.month == 1
        ? currentDate.year - 1
        : currentDate.year;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 47 / 82,
        mainAxisSpacing: 8.sp,
        crossAxisSpacing: 6.sp,
      ),
      itemCount: totalCells > 35 ? 42 : 35,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) {
        if (index > totalCells - 1) {
          return _buildDisabledItem(
            index - totalCells + 1,
            enHabitDailyStatus.none,
          );
        }

        if (index < startOffset) {
          final day = prevMonthDays - startOffset + index + 1;
          final dateKey = _formatDateKey(prevYear, prevMonth, day);
          final state = habit.logs[dateKey] ?? enHabitDailyStatus.none;
          return _buildDisabledItem(day, state);
        }

        final day = index - startOffset + 1;
        final dateKey = _formatDateKey(
          currentDate.year,
          currentDate.month,
          day,
        );
        final state = habit.logs[dateKey] ?? enHabitDailyStatus.none;

        final date = DateTime(currentDate.year, currentDate.month, day);
        final weekDay = date.weekday == 7 ? 0 : date.weekday;

        return CalenderGridViewItem(
          themeColor: themeColor,
          number: day,
          habitCompletionState: state,
          isActive: true,
          onTap: () {
            final isInFrequency = habit.frequency.contains(weekDay);
            final isFutureDay = date.isAfter(today);
            final isInCurrentMonth =
                currentDate.year == today.year &&
                currentDate.month == today.month;

            if (!isInCurrentMonth) {
              buildClosableSnackBar(
                context,
                message: "You can't log a habit for a different month.",
              );
              return;
            }

            if (!isInFrequency) {
              buildClosableSnackBar(
                context,
                message: 'This day is not in your habit schedule.',
              );
              return;
            }

            if (isFutureDay) {
              buildClosableSnackBar(
                context,
                message: "You can't log a habit for a future day.",
              );
              return;
            }
            context.read<HomeCubit>().cycleHabitStatus(habit.id, date);
          },
        );
      },
    );
  }

  CalenderGridViewItem _buildDisabledItem(
    int number,
    enHabitDailyStatus state,
  ) {
    return CalenderGridViewItem(
      themeColor: _mutedThemeColor,
      number: number,
      habitCompletionState: state,
      isActive: false,
    );
  }
}
