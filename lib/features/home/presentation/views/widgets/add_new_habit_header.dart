
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/custom_circle_icon_button.dart';

class AddNewHabitHeader extends StatelessWidget {
  const AddNewHabitHeader({
    super.key,
    required this.backToHome,
  });

  final VoidCallback? backToHome;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Text("New Habit", style: AppStyles.textStyle18),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: CustomCircleIconButton(
            onTap: () {
              backToHome?.call();
            },
            icon: FontAwesomeIcons.arrowLeft,
          ),
        ),
      ],
    );
  }
}
