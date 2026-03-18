import 'package:flutter/material.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class HabitsCompletedDate extends StatelessWidget {
  const HabitsCompletedDate({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        7,
        (index) => Text(
          _getDate(index),
          style: AppStyles.textStyle12.copyWith(
            color: AppColors.primaryColor.withValues(alpha: .7),
          ),
        ),
      ),
    );
  }

  String _getDate(int index) {
    final now = DateTime.now().add(Duration(days: index));
    return "${now.day}/${now.month}";
  }
}
