import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_router.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class SignUpText extends StatelessWidget {
  const SignUpText({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          GoRouter.of(context).pushReplacement(AppRouter.kCreateAccountView),
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
