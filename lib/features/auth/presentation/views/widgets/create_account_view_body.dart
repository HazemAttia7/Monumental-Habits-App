import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/utils/assets_data.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/core/utils/monumental_habits_icons.dart';
import 'package:pixel_true_app/core/widgets/custom_button.dart';
import 'package:pixel_true_app/core/widgets/custom_text_form_field.dart';
import 'package:pixel_true_app/features/auth/presentation/views/widgets/custom_check_box.dart';
import 'package:pixel_true_app/features/auth/presentation/views/widgets/login_text.dart';
import 'package:pixel_true_app/features/auth/presentation/views/widgets/sign_in_with_section.dart';

class CreateAccountViewBody extends StatefulWidget {
  const CreateAccountViewBody({super.key});

  @override
  State<CreateAccountViewBody> createState() => _CreateAccountViewBodyState();
}

class _CreateAccountViewBodyState extends State<CreateAccountViewBody> {
  bool _keepSignedInCheckBox = false, _emailMeCheckBox = false;
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
              CustomTextFormField(
                prefixIcon: Icons.person_outline_rounded,
                hintText: "Username",
                iconSize: 25.sp,
                fillColor: Colors.white,
              ),
              Gap(8.h),
              CustomTextFormField(
                prefixIcon: MonumentalHabitsIcons.email,
                hintText: "Email",
                iconSize: 15.sp,
                fillColor: Colors.white,
              ),
              Gap(8.h),
              const CustomTextFormField(
                prefixIcon: MonumentalHabitsIcons.lock,
                hintText: "Password",
                fillColor: Colors.white,
                isPassword: true,
              ),
              Gap(28.h),
              CustomCheckbox(
                value: _keepSignedInCheckBox,
                onChanged: (bool? value) {
                  setState(() {
                    _keepSignedInCheckBox = value ?? false;
                  });
                },
                text: 'Keep me signed in',
                checkColor: AppColors.primaryColor,
                baseColor: AppColors.secondaryColor,
                textStyle: AppStyles.textStyle16.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Gap(19.h),
              CustomCheckbox(
                value: _emailMeCheckBox,
                onChanged: (bool? value) {
                  setState(() {
                    _emailMeCheckBox = value ?? false;
                  });
                },
                text: 'Email me about special pricing and more',
                checkColor: AppColors.primaryColor,
                baseColor: AppColors.secondaryColor,
                textStyle: AppStyles.textStyle16.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Gap(28.h),
              CustomButton(text: "Create Account", onTap: () {}),
              Gap(20.h),
              const SignInWithSection(),
              Gap(32.h),
              const LoginText(),
              Gap(34.h),
            ],
          ),
        ),
      ),
    );
  }
}
