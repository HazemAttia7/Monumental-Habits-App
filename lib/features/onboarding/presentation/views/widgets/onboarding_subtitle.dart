import 'package:flutter/material.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class OnboardingSubtitle extends StatelessWidget {
  const OnboardingSubtitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: AppStyles.textStyle17.copyWith(
            color: AppColors.primaryColor,
            height: 1.3,
          ),
          children: const [
            TextSpan(text: ("WE CAN")),
            TextSpan(
              text: " HELP YOU ",
              style: TextStyle(color: AppColors.secondaryColor),
            ),
            TextSpan(text: "TO BE BETTER VERSION OF"),
            TextSpan(
              text: " YOURSELF.",
              style: TextStyle(color: AppColors.secondaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
