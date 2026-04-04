import 'package:flutter/material.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class CardHeader extends StatelessWidget {
  final String text;
  const CardHeader({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppStyles.textStyle14.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColors.secondaryColor.withValues(alpha: .5),
      ),
    );
  }
}
