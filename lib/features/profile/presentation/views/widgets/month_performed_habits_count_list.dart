import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/enums/habit_enums.dart';
import 'package:pixel_true_app/core/helper/date_helper.dart';
import 'package:pixel_true_app/core/managers/cubits/habits_cubit/habits_cubit.dart';
import 'package:pixel_true_app/features/home/data/models/habit_model.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/habits_completed_indicator.dart';

final now = DateTime.now();

class MonthPerformedHabitsCountList extends StatelessWidget {
  const MonthPerformedHabitsCountList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HabitsCubit, HabitsState>(
      buildWhen: (previous, current) => current is HabitsLoaded,
      builder: (context, state) {
        if (state is! HabitsLoaded) return const SizedBox.shrink();

        final habits = state.inProgressHabits;
        final countList = _getCount(habits);

        return SizedBox(
          height: 71.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: now.day,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: HabitsCompletedIndicator(
                  value: countList[index],
                  habitsLength: state.inProgressHabits.length,
                  date: _getDate(index),
                ),
              );
            },
          ),
        );
      },
    );
  }

  List<int> _getCount(List<Habit> habits) {
    List<int> countList = List.filled(now.day, 0);
    for (int index = 0; index < countList.length; index++) {
      for (int j = 0; j < habits.length; j++) {
        final key = dateKey(
          DateTime.now().subtract(Duration(days: countList.length - 1 - index)),
        );
        final log = habits[j].logs[key];
        if (log == enHabitDailyStatus.complete ||
            log == enHabitDailyStatus.partial) {
          countList[index]++;
        }
      }
    }
    return countList;
  }

  String _getDate(int index) {
    final date = DateTime(now.year, now.month, index + 1);
    if (date.day == now.day) return "Today";
    return "${date.day}/${date.month}";
  }

  int daysInCurrentMonth() {
    return DateTime(now.year, now.month + 1, 0).day;
  }
}
