import 'package:flutter/material.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/shimmer/habit_tracking_widget_shimmer.dart';

class HabitsTrackingListShimmer extends StatelessWidget {
  const HabitsTrackingListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) => const HabitTrackingWidgetShimmer(),
    );
  }
}
