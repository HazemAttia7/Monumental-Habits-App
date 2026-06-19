import 'package:flutter/material.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class NameWidget extends StatelessWidget {
  final String name;
  const NameWidget({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: AppStyles.textStyle16),
        Text(
          "Name",
          style: AppStyles.textStyle12.copyWith(
            color: AppColors.secondaryColor.withValues(alpha: .5),
          ),
        ),
      ],
    );
  }
}
