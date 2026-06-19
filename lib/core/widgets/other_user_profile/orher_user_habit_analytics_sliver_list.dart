import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/managers/cubits/other_user_habits_cubit/other_user_habits_cubit.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/habits_analytics_sliver_list_item.dart';

class OtherUserHabitsAnalyticsSliverList extends StatelessWidget {
  final String? query;
  const OtherUserHabitsAnalyticsSliverList({super.key, this.query = ""});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtherUserHabitsCubit, OtherUserHabitsState>(
      buildWhen: (previous, current) => current is OtherUserHabitsLoaded,
      builder: (context, state) {
        if (state is! OtherUserHabitsLoaded) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }

        final filtered = state.habits
            .where((h) => h.name.toLowerCase().contains(query!.toLowerCase()))
            .toList();

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
                    HabitsAnalyticsSliverListItem(habit: filtered[index], noAnalytics: true,),
                separatorBuilder: (context, index) => Gap(16.h),
              );
      },
    );
  }
}
