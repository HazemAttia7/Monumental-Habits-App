import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/utils/assets_data.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/core/widgets/animated_slide_widget.dart';
import 'package:pixel_true_app/core/widgets/animated_top_padding.dart';
import 'package:pixel_true_app/core/widgets/custom_animated_scale.dart';
import 'package:pixel_true_app/core/widgets/staggered_item.dart';
import 'package:pixel_true_app/features/auth/presentation/views/widgets/create_account_form.dart';
import 'package:pixel_true_app/features/auth/presentation/views/widgets/mixed_weight_text.dart';
import 'package:pixel_true_app/features/auth/presentation/views/widgets/sign_in_with_section.dart';

class CreateAccountViewBody extends StatelessWidget {
  final VoidCallback togglePages;
  const CreateAccountViewBody({super.key, required this.togglePages});

  @override
  Widget build(BuildContext context) {
    const delay = 200;
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kPagePadding.w),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(17.h),
                CustomAnimatedScale(
                  child: SvgPicture.asset(
                    AssetsData.createYourAccountImage,
                    height: 200.sp,
                  ),
                ),
                Gap(21.h),
                StaggeredItem(
                  delay: const Duration(milliseconds: delay),
                  child: CustomAnimatedTopPadding(
                    padding: 20,
                    child: Text(
                      "Create your account",
                      style: AppStyles.textStyle24.copyWith(
                        fontFamily: "Klasik",
                      ),
                    ),
                  ),
                ),
                Gap(32.h),
                const CreateAccountForm(),
                Gap(20.h),
                const StaggeredItem(
                  delay: Duration(milliseconds: delay * 3),
                  child: AnimatedSlideWidget(
                    opacityDuration: Duration(milliseconds: 600),
                    child: SignInWithSection(),
                  ),
                ),
                Gap(32.h),
                StaggeredItem(
                  delay: const Duration(milliseconds: delay * 4),
                  child: CustomAnimatedTopPadding(
                    padding: 20,
                    child: MixedWeightText(
                      togglePages: togglePages,
                      normalText: 'Already have an account?',
                      boldText: 'Sign In',
                    ),
                  ),
                ),
                Gap(34.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
