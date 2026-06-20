import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/stat_card.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/stat_card_label.dart';

class HabitAnalyticsShimmer extends StatelessWidget {
  const HabitAnalyticsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4.h,
      children: [
        Row(
          spacing: 8.w,
          children: const [
            Expanded(flex: 2, child: StatCardLabel(label: 'streaks')),
            Expanded(child: StatCardLabel(label: 'ease')),
          ],
        ),
        Row(
          spacing: 8.w,
          children: const [
            Expanded(
              child: StatCard(
                isDisabled: true,
                title: 'current',
                subtitle: "day",
                value: 100,
              ),
            ),
            Expanded(
              child: StatCard(title: 'longest', subtitle: "day", value: 100),
            ),
            Expanded(
              child: StatCard(title: 'easiness', subtitle: 'score', value: 10),
            ),
          ],
        ),
      ],
    );
  }
}
