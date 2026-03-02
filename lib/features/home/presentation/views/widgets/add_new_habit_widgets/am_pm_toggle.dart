import 'package:flutter/material.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_new_habit_widgets/am_pm_container.dart';

class AmPmToggle extends StatelessWidget {
  const AmPmToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: AmPmContainer(
            period: 'am',
            textColor: AppColors.primaryColor,
            backColor: AppColors.secondaryColor,
          ),
        ),
        Expanded(
          child: AmPmContainer(
            period: "pm",
            textColor: AppColors.secondaryColor,
            backColor: AppColors.scaffoldColor,
          ),
        ),
      ],
    );
  }
}
