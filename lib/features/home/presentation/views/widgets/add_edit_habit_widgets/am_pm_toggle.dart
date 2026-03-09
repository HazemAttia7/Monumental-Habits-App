import 'package:flutter/material.dart';
import 'package:pixel_true_app/core/enums/am_pm_enums.dart';
import 'package:pixel_true_app/features/home/presentation/managers/add_edit_habit_controller.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_edit_habit_widgets/am_pm_container.dart';
import 'package:provider/provider.dart';

class AmPmToggle extends StatelessWidget {
  const AmPmToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AddEditHabitController>(context);
    return Row(
      children: [
        Expanded(
          child: AmPmContainer(
            period: 'am',
            isSelected: controller.selectedPeriod == enAmPm.am,
            toggle: () => controller.toggleAmPm(clickedPeriod: enAmPm.am),
          ),
        ),
        Expanded(
          child: AmPmContainer(
            period: "pm",
            isSelected: controller.selectedPeriod == enAmPm.pm,
            toggle: () => controller.toggleAmPm(clickedPeriod: enAmPm.pm),
          ),
        ),
      ],
    );
  }
}
