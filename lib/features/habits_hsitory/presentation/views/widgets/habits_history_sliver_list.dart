import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel_true_app/core/managers/cubits/habits_cubit/habits_cubit.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

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

        final filtered = state.habitsForStatus(status);

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
}
