import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel_true_app/core/managers/cubits/habits_cubit/habits_cubit.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/home/data/models/habit_model.dart';

class HabitsHistorySliverList extends StatelessWidget {
  final String status;
  const HabitsHistorySliverList({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HabitsCubit, HabitsState>(
      buildWhen: (previous, current) => current is HabitsLoaded,
      builder: (context, state) {
        if (state is! HabitsLoaded) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }

        final filtered = _getFilteredHabits(state);

        return filtered.isEmpty
            ? SliverToBoxAdapter(
                child: Center(
                  child: Text(
                    "No habits found !",
                    style: AppStyles.textStyle17,
                  ),
                ),
              )
            : SliverToBoxAdapter(
                child: Center(
                  child: Text(
                    "WORK IN PROGRESS !",
                    style: AppStyles.textStyle17,
                  ),
                ),
              ); // HabitsHistoryListItem(habit: filtered[index]), <-- TODO
      },
    );
  }

  List<Habit> _getFilteredHabits(HabitsLoaded state) {
    switch (status.toLowerCase()) {
      case "all":
        return state.habits;
      case 'completed':
        return state.completedHabits;
      case 'missed':
        return state.missedHabits;
      case 'in progress':
      case 'inprogress':
        return state.inProgressHabits;
      default:
        return state.habits;
    }
  }
}
