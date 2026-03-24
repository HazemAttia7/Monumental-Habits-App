import 'package:flutter/material.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/completion_ratio_widget.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/status_badge.dart';

class ItemFooter extends StatelessWidget {
  const ItemFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CompletionRatioWidget(ratio: 90),
        StatusBadge(title: 'completed', icon: Icons.check_circle),
      ],
    );
  }
}
