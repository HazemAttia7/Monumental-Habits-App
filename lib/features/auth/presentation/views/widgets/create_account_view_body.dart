import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/utils/assets_data.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/features/auth/presentation/views/widgets/create_account_form.dart';
import 'package:pixel_true_app/features/auth/presentation/views/widgets/mixed_weight_text.dart';
import 'package:pixel_true_app/features/auth/presentation/views/widgets/sign_in_with_section.dart';

class CreateAccountViewBody extends StatelessWidget {
  final VoidCallback togglePages;
  const CreateAccountViewBody({super.key, required this.togglePages});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kPagePadding.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(17.h),
              Image.asset(AssetsData.createYourAccountImage, height: 200.sp),
              Gap(21.h),
              Text(
                "Create your account",
                style: AppStyles.textStyle24.copyWith(fontFamily: "Klasik"),
              ),
              Gap(32.h),
              const CreateAccountForm(),
              Gap(20.h),
              const SignInWithSection(),
              Gap(32.h),
              MixedWeightText(
                togglePages: togglePages,
                normalText: 'Already have an account?',
                boldText: 'Sign In',
              ),
              Gap(34.h),
            ],
          ),
        ),
      ),
    );
  }
}
