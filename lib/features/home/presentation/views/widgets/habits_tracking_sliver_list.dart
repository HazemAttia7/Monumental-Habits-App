import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/home/data/models/habit_model.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/habit_tracking_widget.dart';

class HabitsTrackingSliverList extends StatelessWidget {
  final List<ScrollController> scrollControllers;
  final List<Habit> habitsList;
  final bool isLoading;
  const HabitsTrackingSliverList({
    super.key,
    required this.scrollControllers,
    required this.habitsList,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return habitsList.isEmpty
        ? SliverFillRemaining(
            child: SizedBox(
              child: Center(
                child: Text(
                  "No active habits yet. Add one to get started.",
                  textAlign: TextAlign.center,
                  style: AppStyles.textStyle17,
                ),
              ),
            ),
          )
        : SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              // Create a controller for each habit if it doesn't exist yet
              if (scrollControllers.length <= index) {
                final ctrl = ScrollController();
                scrollControllers.add(ctrl);
              }

              return Padding(
                padding: EdgeInsets.only(
                  bottom: index == habitsList.length - 1 ? 0 : 8.sp,
                ),
                child: HabitTrackingWidget(
                  isLoading: isLoading,
                  scrollController: scrollControllers[index],
                  habit: habitsList[index],
                  color:
                      AppColors.habitsColorsSequence[index %
                          AppColors.habitsColorsSequence.length],
                ),
              );
            }, childCount: habitsList.length),
          );
  }
}
