import 'package:flutter/material.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class DeleteDialogMessage extends StatelessWidget {
  final String reminderTime;
  const DeleteDialogMessage({super.key, required this.reminderTime});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: AppStyles.textStyle16.copyWith(
          color: Colors.black54,
          fontWeight: FontWeight.w500,
        ),
        children: [
          const TextSpan(text: 'Are you sure you want to remove\n'),
          TextSpan(
            text: '"$reminderTime"',
            style: AppStyles.textStyle16.copyWith(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const TextSpan(text: ' from your reminders?'),
        ],
      ),
    );
  }
}
