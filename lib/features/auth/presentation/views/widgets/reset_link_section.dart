import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/core/widgets/custom_button.dart';
import 'package:pixel_true_app/core/widgets/custom_text_form_field.dart';

class ResetLinkSection extends StatelessWidget {
  const ResetLinkSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(kPagePadding.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Text(
            "Enter your registered email below to receive password reset instruction",
            style: AppStyles.textStyle14,
            textAlign: TextAlign.center,
          ),
          Gap(30.h),
          const CustomTextFormField(hintText: "Email"),
          Gap(32.h),
          CustomButton(onTap: () {}, text: "Send Reset Link"),
        ],
      ),
    );
  }
}
