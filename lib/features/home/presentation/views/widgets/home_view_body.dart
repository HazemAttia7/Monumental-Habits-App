import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel_true_app/features/home/data/models/habit_model.dart';
import 'package:pixel_true_app/core/managers/cubits/habits_cubit/habits_cubit.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/habits_loaded_view.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/shimmer/habits_loading_view.dart';

// TODO : make habits shimmer list more than 3 items
class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HabitsCubit, HabitsState>(
      builder: (context, state) {
        if (state is HabitsError) {
          return SliverFillRemaining(
            child: Center(child: Text(state.errMessage)),
          );
        }
        if (state is HabitsLoading) {
          return const HabitsLoadingView();
        }
        final List<Habit> habits = state is HabitsLoaded
            ? state.inProgressHabits
            : [];

        return HabitsLoadedView(habits: habits);
      },
    );
  }
}
