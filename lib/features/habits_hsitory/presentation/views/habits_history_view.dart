import 'package:flutter/material.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/features/habits_hsitory/presentation/views/widgets/habits_history_view_body.dart';

class HabitsHistoryView extends StatelessWidget {
  const HabitsHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.lerp(Colors.white, AppColors.secondaryColor, 0.08),
      body: const HabitsHistoryViewBody(),
    );
  }
}
