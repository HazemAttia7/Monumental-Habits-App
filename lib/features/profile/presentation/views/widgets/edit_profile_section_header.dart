import 'package:flutter/material.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class EditProfileSectionHeader extends StatelessWidget {
  final String text;
  const EditProfileSectionHeader({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppStyles.textStyle22.copyWith(
        color: AppColors.primaryColor.withValues(alpha: .75),
      ),
    );
  }
}
