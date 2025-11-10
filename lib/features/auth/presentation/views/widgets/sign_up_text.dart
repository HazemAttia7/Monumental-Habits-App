import 'package:flutter/material.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class SignUpText extends StatelessWidget {
  final VoidCallback togglePages;
  const SignUpText({super.key, required this.togglePages});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: togglePages,
      child: RichText(
        text: TextSpan(
          style: AppStyles.textStyle14.copyWith(
            fontWeight: FontWeight.normal,
            color: AppColors.primaryColor,
          ),
          children: [
            const TextSpan(text: "Don’t have an account? "),
            TextSpan(
              text: "Sign up",
              style: AppStyles.textStyle14.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
