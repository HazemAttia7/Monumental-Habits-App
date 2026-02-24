import 'package:flutter/material.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class CustomSwitcher extends StatelessWidget {
  final String text;
  final void Function(bool)? onChanged;
  const CustomSwitcher({super.key, required bool isSwitched, this.onChanged, required this.text})
    : _isSwitched = isSwitched;

  final bool _isSwitched;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.scale(
          scale: 0.7,
          child: Switch(
            activeThumbColor: AppColors.secondaryColor,
            value: _isSwitched,
            onChanged: onChanged,
          ),
        ),
        Text(
          text,
          style: AppStyles.textStyle16.copyWith(
            color: _isSwitched
                ? AppColors.secondaryColor
                : AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}
