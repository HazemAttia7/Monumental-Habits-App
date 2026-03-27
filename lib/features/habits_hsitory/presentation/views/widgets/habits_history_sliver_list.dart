import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/enums/habits_history_enums.dart';
import 'package:pixel_true_app/core/managers/cubits/habits_cubit/habits_cubit.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/habits_hsitory/presentation/views/widgets/habits_history_sliver_list_item.dart';

class HabitsHistorySliverList extends StatelessWidget {
  final enFilterHabitsByStatus status;
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
            ? SliverFillRemaining(
                child: Center(
                  child: Text(
                    "No habits found !",
                    style: AppStyles.textStyle17,
                  ),
                ),
              )
            : SliverList.separated(
                itemCount: filtered.length,
                itemBuilder: (context, index) =>
                    HabitsHistorySliverListItem(habit: filtered[index]),
                separatorBuilder: (context, index) => Gap(16.h),
              );
      },
    );
  }
}
