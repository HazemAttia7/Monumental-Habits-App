import 'package:flutter/material.dart';
import 'package:pixel_true_app/features/home/data/models/habit_model.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/habit_analysis_widgets/habit_analysis_view_body.dart';

// TODO : Refactpr view be creating manager
class HabitAnalysisView extends StatelessWidget {
  final Habit habit;
  final Color themeColor;
  const HabitAnalysisView({
    super.key,
    required this.habit,
    required this.themeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.lerp(themeColor, Colors.white, 0.9),
      body: HabitAnalysisViewBody(habit: habit, themeColor: themeColor),
    );
  }
}
