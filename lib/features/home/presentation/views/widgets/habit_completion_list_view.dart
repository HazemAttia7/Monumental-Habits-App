import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/enums/habit_comletion_state_enum.dart';
import 'package:pixel_true_app/core/helper/date_helper.dart';
import 'package:pixel_true_app/core/widgets/closable_snack_bar.dart';
import 'package:pixel_true_app/features/home/data/models/habit_model.dart';
import 'package:pixel_true_app/features/home/presentation/managers/cubits/home_cubit/home_cubit.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/habit_completion_list_view_item.dart';

class HabitCompletionListView extends StatelessWidget {
  final ScrollController scrollController;
  final Color color;
  final Habit habit;
  const HabitCompletionListView({
    super.key,
    required this.scrollController,
    required this.color,
    required this.habit,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday % 7));

    return SizedBox(
      height: 50.sp,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (_, index) => Padding(
          padding: EdgeInsets.only(right: 6.sp),
          child: habit.frequency.contains(index)
              ? AspectRatio(
                  aspectRatio: 1,
                  child: HabitCompletionListViewItem(
                    isActive: true,
                    habitCompletionState:
                        habit.logs[dateKey(
                          weekStart.add(Duration(days: index)),
                        )] ??
                        enHabitCompletionState.none,
                    themeColor: color,
                    onTap: () {
                      final isFutureDay = weekStart
                          .add(Duration(days: index))
                          .isAfter(now);

                      if (isFutureDay) {
                        buildClosableSnackBar(
                          context,
                          message: "You can't log a habit for a future day.",
                        );
                        return;
                      }
                      BlocProvider.of<HomeCubit>(context).cycleHabitStatus(
                        habit.id,
                        weekStart.add(Duration(days: index)),
                      );
                    },
                  ),
                )
              : SizedBox(width: 50.sp, height: 50.sp),
        ),
      ),
    );
  }
}
