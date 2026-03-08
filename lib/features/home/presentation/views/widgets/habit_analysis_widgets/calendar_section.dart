import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/helper/date_helper.dart';
import 'package:pixel_true_app/features/home/data/models/habit_model.dart';
import 'package:pixel_true_app/features/home/presentation/managers/cubits/home_cubit/home_cubit.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/habit_analysis_widgets/calender_grid_view.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/habit_analysis_widgets/month_actions.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/habit_analysis_widgets/week_days_row.dart';

class CalendarSection extends StatefulWidget {
  final Habit habit;
  final Color themeColor;
  const CalendarSection({
    super.key,
    required this.themeColor,
    required this.habit,
  });

  @override
  State<CalendarSection> createState() => _CalendarSectionState();
}

class _CalendarSectionState extends State<CalendarSection> {
  DateTime _currentDate = DateTime(DateTime.now().year, DateTime.now().month, 1);

  @override
  Widget build(BuildContext context) {
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
              onNextTap: () => setState(() {
                _currentDate = DateTime(
                  _currentDate.year,
                  _currentDate.month + 1,
                  1,
                );
              }),
              onBackTap: () => setState(() {
                _currentDate = DateTime(
                  _currentDate.year,
                  _currentDate.month - 1,
                  1,
                );
              }),
              month: monthName(_currentDate.month),
            ),
          ),
          Gap(16.h),
          const WeekDaysRow(),
          Gap(8.h),
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is! HabitsLoaded) return const SizedBox.shrink();
              final habit = state.habits.firstWhere(
                (h) => h.id == widget.habit.id,
              );
              return CalendarGridView(
                habit: habit,
                themeColor: widget.themeColor,
                currentDate: _currentDate,
              );
            },
          ),
        ],
      ),
    );
  }
}