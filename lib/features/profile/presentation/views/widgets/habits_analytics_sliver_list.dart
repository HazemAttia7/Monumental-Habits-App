import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/managers/cubits/habits_cubit/habits_cubit.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/habits_analytics_sliver_list_item.dart';

class HabitsAnalyticsSliverList extends StatelessWidget {
  final String query;
  const HabitsAnalyticsSliverList({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HabitsCubit, HabitsState>(
      buildWhen: (previous, current) => current is HabitsLoaded,
      builder: (context, state) {
        if (state is! HabitsLoaded) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }

        final filtered = state.habits
            .where((h) => h.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

        return filtered.isEmpty
            ? SliverToBoxAdapter(
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
                    HabitsAnalyticsSliverListItem(habit: filtered[index]),
                separatorBuilder: (context, index) => Gap(16.h),
              );
      },
    );
  }
}
