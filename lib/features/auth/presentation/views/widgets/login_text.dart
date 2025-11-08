import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_router.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class LoginText extends StatelessWidget {
  const LoginText({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => GoRouter.of(context).pushReplacement(AppRouter.kLoginView),
      child: RichText(
        text: TextSpan(
          style: AppStyles.textStyle14.copyWith(
            fontWeight: FontWeight.normal,
            color: AppColors.primaryColor,
          ),
          children: [
            const TextSpan(text: "Already have an account? "),
            TextSpan(
              text: "Sign In",
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
