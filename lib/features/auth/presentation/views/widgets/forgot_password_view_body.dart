import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/utils/assets_data.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/core/widgets/animated_slide_widget.dart';
import 'package:pixel_true_app/core/widgets/animated_top_padding.dart';
import 'package:pixel_true_app/core/widgets/custom_animated_scale.dart';
import 'package:pixel_true_app/core/widgets/custom_icon_button.dart';
import 'package:pixel_true_app/features/auth/presentation/views/widgets/remember_password_text.dart';
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
              TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                tween: Tween(begin: 0.0, end: 1.0),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: CustomIconButton(
                        onTap: () => GoRouter.of(context).pop(),
                        icon: Icons.arrow_back_rounded,
                      ),
                    ),
                  );
                },
              ),
              Gap(37.h),
              CustomAnimatedTopPadding(
                padding: 20,
                child: Text(
                  "Forgot your password?",
                  style: AppStyles.textStyle24.copyWith(fontFamily: "Klasik"),
                ),
              ),
              Gap(39.h),
              CustomAnimatedScale(
                opacityDuration: const Duration(milliseconds: 700),
                child: SvgPicture.asset(
                  AssetsData.forgotPasswordImage,
                  width: 264.sp,
                ),
              ),
              Gap(45.h),
              const AnimatedSlideWidget(
                opacityDuration: Duration(milliseconds: 500),
                child: ResetLinkSection(),
              ),
              Gap(20.h),
              const CustomAnimatedTopPadding(
                padding: 20,
                child: RememberPasswordText(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
