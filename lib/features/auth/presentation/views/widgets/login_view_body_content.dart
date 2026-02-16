import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/utils/assets_data.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pixel_true_app/features/auth/presentation/views/widgets/continue_with_button.dart';
import 'package:pixel_true_app/core/widgets/custom_circle_icon_button.dart';
import 'package:pixel_true_app/features/auth/presentation/views/widgets/help_dialog.dart';
import 'package:pixel_true_app/features/auth/presentation/views/widgets/login_sheet.dart';

class LoginViewBodyContent extends StatefulWidget {
  final VoidCallback togglePages;
  const LoginViewBodyContent({super.key, required this.togglePages});

  @override
  State<LoginViewBodyContent> createState() => _LoginViewBodyContentState();
}

class _LoginViewBodyContentState extends State<LoginViewBodyContent> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(45.h),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: kPagePadding.w),
            child: CustomCircleIconButton(
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
            image: AssetsData.googleIcon,
            text: 'Continue with Google',
            onTap: continueWithGoogle,
            isLoading: _isLoading,
          ),
        ),
        Gap(8.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: kPagePadding.w),
          child: ContinueWithButton(
            image: AssetsData.facebookIcon,
            text: 'Continue with Facebook',
            onTap: () {
              // TODO : Login With Facebook Account
            },
          ),
        ),
        Gap(25.h),
        LoginSheet(togglePages: widget.togglePages),
      ],
    );
  }

  void continueWithGoogle() async {
    setState(() {
      _isLoading = true;
    });
    await BlocProvider.of<AuthCubit>(context).signupWithGoogle();
    setState(() {
      _isLoading = false;
    });
  }
}
