import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/custom_circular_progress_indicator.dart';

class HabitsCompletedIndicator extends StatelessWidget {
  final int value, habitsLength;
  final String date;
  const HabitsCompletedIndicator({
    super.key,
    required this.value,
    required this.habitsLength,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CustomCircularProgressIndicator(
              value: value,
              color: _getColor(value),
              habitsLength: habitsLength,
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  value.toString(),
                  style: AppStyles.textStyle14.copyWith(
                    color: _getColor(value),
                  ),
                ),
              ),
            ),
          ],
        ),
        Gap(12.h),
        Text(
          date,
          style: AppStyles.textStyle12.copyWith(
            color: AppColors.secondaryColor.withValues(alpha: .7),
          ),
        ),
      ],
    );
  }

  Color _getColor(int value) {
    if (value == 0) {
      return Colors.redAccent;
    } else if (value >= habitsLength) {
      return AppColors.primaryColor;
    } else {
      return AppColors.secondaryColor;
    }
  }
}
