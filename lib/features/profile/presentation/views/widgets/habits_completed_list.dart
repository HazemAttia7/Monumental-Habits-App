import 'package:flutter/material.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/habits_completed_indicator.dart';

class HabitsCompletedList extends StatelessWidget {
  final List<int> values;
  const HabitsCompletedList({super.key, required this.values});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (index) {
        return HabitsCompletedIndicator(value: values[index]);
      }),
    );
  }
}
