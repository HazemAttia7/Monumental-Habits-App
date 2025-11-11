import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class RememberPasswordText extends StatelessWidget {
  const RememberPasswordText({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => GoRouter.of(context).pop(),
      child: RichText(
        text: TextSpan(
          style: AppStyles.textStyle14.copyWith(
            fontWeight: FontWeight.normal,
            color: AppColors.primaryColor,
          ),
          children: [
            const TextSpan(text: "Remember password? "),
            TextSpan(
              text: "Login",
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
