import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/custom_icon_button.dart';

class HabitAnalysisHeader extends StatelessWidget {
  const HabitAnalysisHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomIconButton(onTap: () {
          Navigator.pop(context);
        }, icon: FontAwesomeIcons.arrowLeft),
        Text("Habit Analysis", style: AppStyles.textStyle18),
        CustomIconButton(onTap: () {
          // TODO : Edit Habit --> go to add new habit view but in edit mode
        }, icon: FontAwesomeIcons.pencil),
        
      ],
    );
  }
}
