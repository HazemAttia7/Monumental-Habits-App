import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pixel_true_app/core/enums/habit_enums.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/custom_icon_button.dart';

class AddEditHabitHeader extends StatelessWidget {
  const AddEditHabitHeader({
    super.key,
    required this.backToHome,
    this.themeColor,
    required this.mode,
  });

  final VoidCallback? backToHome;
  final Color? themeColor;
  final enHabitFormMode mode;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Text(
            "${mode == enHabitFormMode.create ? "New" : "Edit"} Habit",
            style: AppStyles.textStyle18,
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: CustomIconButton(
            onTap: () {
              backToHome?.call();
            },
            iconColor: themeColor,
            backColor: themeColor?.withValues(alpha: .1),
            icon: FontAwesomeIcons.arrowLeft,
          ),
        ),
      ],
    );
  }
}
