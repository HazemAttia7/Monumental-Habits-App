import 'package:flutter/material.dart';
import 'package:pixel_true_app/core/enums/habit_enums.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_new_habit_widgets/add_edit_habit_view_body.dart';

class AddEditHabitView extends StatelessWidget {
  final VoidCallback? backToHome;
  final enHabitFormMode habitFormMode;
  final Color? themeColor;
  const AddEditHabitView({
    super.key,
    this.backToHome,
    required this.habitFormMode,
    this.themeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: habitFormMode == enHabitFormMode.create
          ? Colors.transparent
          : Color.lerp(
              themeColor ?? AppColors.secondaryColor,
              Colors.white,
              0.9,
            ),
      body: AddEditHabitViewBody(
        backToHome: backToHome,
        mode: habitFormMode,
        themeColor: themeColor,
      ),
    );
  }
}
