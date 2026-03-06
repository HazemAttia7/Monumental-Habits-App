import 'package:flutter/material.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/habit_analysis_widgets/icon_button_with_shadow.dart';

class MonthActions extends StatelessWidget {
  final VoidCallback onNextTap, onBackTap;
  final String month;
  const MonthActions({
    super.key,
    required this.onNextTap,
    required this.onBackTap,
    required this.month,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButtonWithShadow(
          icon: Icons.arrow_back_ios,
          color: AppColors.primaryColor,
          onTap: onBackTap,
        ),
        Text(month, style: AppStyles.textStyle16),
        IconButtonWithShadow(
          icon: Icons.arrow_forward_ios,
          color: AppColors.primaryColor,
          onTap: onNextTap,
        ),
      ],
    );
  }
}
