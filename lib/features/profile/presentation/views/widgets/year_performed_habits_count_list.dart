import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/enums/habit_enums.dart';
import 'package:pixel_true_app/core/helper/date_helper.dart';
import 'package:pixel_true_app/core/managers/cubits/habits_cubit/habits_cubit.dart';
import 'package:pixel_true_app/features/home/data/models/habit_model.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/habits_completed_indicator.dart';

final now = DateTime.now();

class YearPerformedHabitsCountList extends StatelessWidget {
  const YearPerformedHabitsCountList({super.key});

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
            itemCount: 12,
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
    List<int> countList = List.filled(12, 0);
    for (int month = 1; month <= 12; month++) {
      final Set<String> performedHabits = {};
      for (int j = 0; j < habits.length; j++) {
        for (var i = 0; i < DateTime(now.year, month + 1, 0).day; i++) {
          final key = dateKey(DateTime(now.year, month, i + 1));
          final log = habits[j].logs[key];
          if (log == enHabitDailyStatus.complete ||
              log == enHabitDailyStatus.partial) {
            performedHabits.add(habits[j].id);
            break;
          }
        }
      }
      countList[month - 1] = performedHabits.length;
    }
    return countList;
  }

  String _getDate(int index) {
    return index + 1 == now.month ? "NOW" : "${index + 1}";
  }
}
