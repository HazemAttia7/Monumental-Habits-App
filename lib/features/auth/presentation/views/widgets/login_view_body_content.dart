import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/utils/assets_data.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/features/auth/presentation/views/widgets/continue_with_button.dart';
import 'package:pixel_true_app/core/widgets/custom_icon_button.dart';
import 'package:pixel_true_app/features/auth/presentation/views/widgets/help_dialog.dart';
import 'package:pixel_true_app/features/auth/presentation/views/widgets/login_section.dart';

class LoginViewBodyContent extends StatelessWidget {
  const LoginViewBodyContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(45.h),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: kPagePadding.w),
            child: CustomIconButton(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => const HelpDialog(),
                );
              },
              icon: FontAwesomeIcons.question,
            ),
          ),
        ),
        Gap(219.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: kPagePadding.w),
          child: Text(
            "WELCOME TO Monumental habits",
            textAlign: TextAlign.center,
            style: AppStyles.textStyle32,
          ),
        ),
        Gap(41.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: kPagePadding.w),
          child: ContinueWithButton(
            image: AssetsData.googleImge,
            text: 'Continue with Google',
            onTap: () {
              // TODO : Login With Google Account
            },
          ),
        ),
        Gap(8.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: kPagePadding.w),
          child: ContinueWithButton(
            image: AssetsData.facebookImage,
            text: 'Continue with Facebook',
            onTap: () {
              // TODO : Login With Facebook Account
            },
          ),
        ),
        Gap(25.h),
        const LoginSection(),
      ],
    );
  }
}
