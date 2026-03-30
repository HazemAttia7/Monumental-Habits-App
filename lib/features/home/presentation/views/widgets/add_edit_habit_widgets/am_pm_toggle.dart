import 'package:flutter/material.dart';
import 'package:pixel_true_app/core/enums/am_pm_enums.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/managers/add_edit_habit_view_controller.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_edit_habit_widgets/am_pm_container.dart';
import 'package:provider/provider.dart';

class AmPmToggle extends StatelessWidget {
  final Color? themeColor;
  const AmPmToggle({super.key, this.themeColor});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AddEditHabitViewController>(context);
    return Row(
      children: [
        Expanded(
          child: AmPmContainer(
            themeColor: themeColor ?? AppColors.primaryColor,
            period: 'am',
            isSelected: controller.selectedPeriod == enAmPm.am,
            toggle: () => controller.toggleAmPm(clickedPeriod: enAmPm.am),
          ),
        ),
        Expanded(
          child: AmPmContainer(
            themeColor: themeColor ?? AppColors.primaryColor,
            period: "pm",
            isSelected: controller.selectedPeriod == enAmPm.pm,
            toggle: () => controller.toggleAmPm(clickedPeriod: enAmPm.pm),
          ),
        ),
      ],
    );
  }
}
