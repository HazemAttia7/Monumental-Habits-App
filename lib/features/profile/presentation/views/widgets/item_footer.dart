import 'package:flutter/material.dart';
import 'package:pixel_true_app/core/enums/habit_enums.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/completion_ratio_widget.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/status_badge.dart';

class ItemFooter extends StatelessWidget {
  final double ratio;
  final enHabitStatus status;
  const ItemFooter({super.key, required this.ratio, required this.status});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CompletionRatioWidget(ratio: ratio),
        StatusBadge(status: status,),
      ],
    );
  }
}
