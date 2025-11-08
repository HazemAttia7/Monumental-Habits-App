import 'package:flutter/material.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class ShowHidePasswrodText extends StatelessWidget {
  final bool isObsecured;
  final VoidCallback onTap;
  const ShowHidePasswrodText({
    super.key,
    required this.onTap,
    required this.isObsecured,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        isObsecured ? "Show" : "Hide",
        style: AppStyles.textStyle14.copyWith(
          decoration: TextDecoration.underline,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
