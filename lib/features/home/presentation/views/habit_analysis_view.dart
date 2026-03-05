import 'package:flutter/material.dart';
import 'package:pixel_true_app/features/home/data/models/habit_model.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/habit_analysis_widgets/habit_analysis_view_body.dart';

class HabitAnalysisView extends StatelessWidget {
  final Habit habit;
  const HabitAnalysisView({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: HabitAnalysisViewBody(habit: habit));
  }
}
