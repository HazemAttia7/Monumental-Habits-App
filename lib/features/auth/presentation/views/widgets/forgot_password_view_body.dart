import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/utils/assets_data.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/core/widgets/custom_icon_button.dart';
import 'package:pixel_true_app/features/auth/presentation/views/widgets/reset_link_section.dart';

class ForgotPasswordViewBody extends StatelessWidget {
  const ForgotPasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kPagePadding.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(8.h),
              Align(
                alignment: Alignment.centerLeft,
                child: CustomIconButton(
                  onTap: () => GoRouter.of(context).pop(),
                  icon: Icons.arrow_back_rounded,
                ),
              ),
              Gap(37.h),
              Text(
                "Forgot your password?",
                style: AppStyles.textStyle24.copyWith(fontFamily: "Klasik"),
              ),
              Gap(39.h),
              Image.asset(AssetsData.forgotPasswordImage, width: 414.sp),
              Gap(45.h),
              const ResetLinkSection(),
              Gap(20.h),
              GestureDetector(
                onTap: () => GoRouter.of(context).pop(),
                child: RichText(
                  text: TextSpan(
                    style: AppStyles.textStyle14.copyWith(
                      fontWeight: FontWeight.normal,
                      color: AppColors.primaryColor,
                    ),
                    children: [
                      const TextSpan(text: "Remember password? "),
                      TextSpan(
                        text: "Login",
                        style: AppStyles.textStyle14.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
