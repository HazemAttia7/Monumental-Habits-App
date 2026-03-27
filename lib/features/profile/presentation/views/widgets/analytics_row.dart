import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/enums/habit_enums.dart';
import 'package:pixel_true_app/features/home/data/models/habit_model.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/stat_card.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/stat_card_label.dart';

class AnalyticsRow extends StatelessWidget {
  final Habit habit;
  const AnalyticsRow({super.key, required this.habit});

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
          children: [
            Expanded(
              child: StatCard(
                isDisabled: habit.status != enHabitStatus.inProgress,
                title: 'current',
                subtitle: _getStreakText(habit.currentStreak),
                value: habit.currentStreak,
              ),
            ),
            Expanded(
              child: StatCard(
                title: 'longest',
                subtitle: _getStreakText(habit.longestStreak),
                value: habit.longestStreak,
              ),
            ),
            Expanded(
              child: StatCard(
                title: 'easiness',
                subtitle: 'score',
                value: habit.easinessScore,
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _getStreakText(int streak) {
    if (streak == 1) {
      return "day";
    } else {
      return "days";
    }
  }
}
