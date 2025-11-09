import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/core/utils/monumental_habits_icons.dart';
import 'package:pixel_true_app/core/widgets/custom_button.dart';
import 'package:pixel_true_app/core/widgets/custom_text_form_field.dart';
import 'package:pixel_true_app/features/auth/presentation/views/widgets/forgot_password_text.dart';
import 'package:pixel_true_app/features/auth/presentation/views/widgets/sign_up_text.dart';

class LoginSection extends StatelessWidget {
  const LoginSection({super.key});

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
          CustomTextFormField(
            prefixIcon: MonumentalHabitsIcons.email,
            hintText: "Email",
            iconSize: 15.sp,
          ),
          Gap(8.h),
          const CustomTextFormField(
            prefixIcon: MonumentalHabitsIcons.lock,
            hintText: "Password",
            isPassword: true,
          ),
          Gap(20.h),
          CustomButton(
            text: "Login",
            onTap: () {
              // TODO : Login Logic
            },
          ),
          Gap(13.h),
          const ForgotPasswordText(),
          Gap(12.h),
          const SignUpText(),
          Gap(28.h),
        ],
      ),
    );
  }
}
