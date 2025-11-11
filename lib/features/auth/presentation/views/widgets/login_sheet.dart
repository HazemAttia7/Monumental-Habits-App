import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/features/auth/presentation/views/widgets/forgot_password_text.dart';
import 'package:pixel_true_app/features/auth/presentation/views/widgets/login_form.dart';
import 'package:pixel_true_app/features/auth/presentation/views/widgets/mixed_weight_text.dart';

class LoginSheet extends StatelessWidget {
  final VoidCallback togglePages;
  const LoginSheet({super.key, required this.togglePages});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: kPagePadding.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        children: [
          Gap(12.h),
          Text(
            "Log in with email",
            style: AppStyles.textStyle16.copyWith(fontWeight: FontWeight.w500),
          ),
          Gap(28.h),
          const LoginForm(),
          Gap(13.h),
          const ForgotPasswordText(),
          Gap(12.h),
          MixedWeightText(togglePages: togglePages, normalText: 'Don’t have an account?',boldText: 'Sign Up',),
          Gap(28.h),
        ],
      ),
    );
  }
}
