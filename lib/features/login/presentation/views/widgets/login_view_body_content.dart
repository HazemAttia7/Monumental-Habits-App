import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/utils/assets_data.dart';
import 'package:pixel_true_app/features/login/presentation/views/widgets/continue_with_button.dart';
import 'package:pixel_true_app/features/login/presentation/views/widgets/help_button.dart';

class LoginViewBodyContent extends StatelessWidget {
  const LoginViewBodyContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(8.h),
        const Align(alignment: Alignment.centerRight, child: HelpButton()),
        const Spacer(),
        Text(
          "WELCOME TO Monumental habits",
          textAlign: TextAlign.center,
          style: AppStyles.textStyle32,
        ),
        Gap(41.h),
        ContinueWithButton(
          image: AssetsData.googleImge,
          text: 'Continue with Google',
          onTap: () {},
        ),
        Gap(8.h),
        ContinueWithButton(
          image: AssetsData.facebookImage,
          text: 'Continue with Facebook',
          onTap: () {},
        ),
        Gap(25.h),
      ],
    );
  }
}
