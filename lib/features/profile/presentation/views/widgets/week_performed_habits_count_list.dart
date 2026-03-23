import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel_true_app/core/enums/habit_enums.dart';
import 'package:pixel_true_app/core/helper/date_helper.dart';
import 'package:pixel_true_app/core/managers/cubits/habits_cubit/habits_cubit.dart';
import 'package:pixel_true_app/features/home/data/models/habit_model.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/habits_completed_indicator.dart';

class WeekPerformedHabitsCountList extends StatelessWidget {
  const WeekPerformedHabitsCountList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HabitsCubit, HabitsState>(
      buildWhen: (previous, current) => current is HabitsLoaded,
      builder: (context, state) {
        if (state is! HabitsLoaded) return const SizedBox.shrink();

        final habits = state.inProgressHabits;
        final countList = _getCount(habits);
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(7, (index) {
            return HabitsCompletedIndicator(
              value: countList[index],
              habitsLength: state.inProgressHabits.length,
              date: _getDate(6 - index),
            );
          }),
        );
      },
    );
  }

  List<int> _getCount(List<Habit> habits) {
    List<int> countList = [0, 0, 0, 0, 0, 0, 0];
    for (int index = 0; index < 7; index++) {
      for (int j = 0; j < habits.length; j++) {
        final key = dateKey(DateTime.now().subtract(Duration(days: 6 - index)));
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
    if (index == 0) return "Today";
    final now = DateTime.now().subtract(Duration(days: index));
    return "${now.day}/${now.month}";
  }
}
