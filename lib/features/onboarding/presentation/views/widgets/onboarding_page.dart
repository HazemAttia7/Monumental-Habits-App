import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String image;
  const OnboardingPage({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Gap(50.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppStyles.textStyle32,
          ),
          Expanded(child: Image.asset(image)),
        ],
      ),
    );
  }
}
