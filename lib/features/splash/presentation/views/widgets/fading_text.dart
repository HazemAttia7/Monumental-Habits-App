import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';

class FadingText extends StatelessWidget {
  const FadingText({super.key, required this.fadeAnimation});

  final Animation<double> fadeAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: fadeAnimation,
      builder: (context, _) {
        return FadeTransition(
          opacity: fadeAnimation,
          child: Text(
            "WELCOME TO Monumental habits",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 35.sp,
              color: AppColors.primaryTextColor,
              fontFamily: "Klasik",
              height: 1,
            ),
          ),
        );
      },
    );
  }
}
