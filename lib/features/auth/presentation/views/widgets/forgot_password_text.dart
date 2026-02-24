import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/core/utils/app_router.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class ForgotPasswordText extends StatelessWidget {
  const ForgotPasswordText({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(6.r),
        onTap: () {
          GoRouter.of(context).push(AppRouter.kForgotPasswordView);
        },
        child: Text(
          "Forgot Password?",
          style: AppStyles.textStyle14.copyWith(
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
