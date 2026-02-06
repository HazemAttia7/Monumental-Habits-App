import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/habit_tracking_widget.dart';

// ignore: must_be_immutable
class HabitsTrackingSliverList extends StatelessWidget {
  final List<ScrollController> scrollControllers;
  const HabitsTrackingSliverList({super.key, required this.scrollControllers});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        // Create a controller for each habit if it doesn't exist yet
        if (scrollControllers.length <= index) {
          final ctrl = ScrollController();
          scrollControllers.add(ctrl);
        }

        return Padding(
          padding: EdgeInsets.only(bottom: index == 4 - 1 ? 0 : 8.sp),
          child: HabitTrackingWidget(
            scrollController: scrollControllers[index],
            text: 'Item ${index + 1}',
            color:
                AppColors.habitsColorsSequence[index %
                    AppColors.habitsColorsSequence.length],
          ),
        );
      }, childCount: 4),
    );
  }
}
