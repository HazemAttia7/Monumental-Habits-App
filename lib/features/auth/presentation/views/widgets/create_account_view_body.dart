import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/utils/assets_data.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/features/auth/presentation/views/widgets/create_account_section.dart';
import 'package:pixel_true_app/features/auth/presentation/views/widgets/login_text.dart';

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
              const CreateAccountSection(),
              Gap(32.h),
               LoginText(togglePages : togglePages),
              Gap(34.h),
            ],
          ),
        ),
      ),
    );
  }
}
