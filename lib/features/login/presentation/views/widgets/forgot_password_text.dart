import 'package:flutter/material.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class ForgotPasswordText extends StatelessWidget {
  const ForgotPasswordText({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO : navigate to forgot password view
      },
      child: Text(
        "Forgot Password?",
        style: AppStyles.textStyle14.copyWith(
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
