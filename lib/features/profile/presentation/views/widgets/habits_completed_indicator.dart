import 'package:flutter/material.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/custom_circular_progress_indicator.dart';

class HabitsCompletedIndicator extends StatelessWidget {
  final int value;
  const HabitsCompletedIndicator({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomCircularProgressIndicator(value: value, color: _getColor(value)),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Text(
              value.toString(),
              style: AppStyles.textStyle14.copyWith(color: _getColor(value)),
            ),
          ),
        ),
      ],
    );
  }

  Color _getColor(int value) {
    if (value == 0) {
      return Colors.redAccent;
    } else if (value >= 7) {
      return AppColors.secondaryColor;
    } else {
      return AppColors.primaryColor;
    }
  }
}
