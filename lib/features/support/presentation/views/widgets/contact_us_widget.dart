import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixel_true_app/core/helper/build_not_implemented_yet_dialog.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/custom_button.dart';

class ContactUsWidget extends StatelessWidget {
  const ContactUsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Still need help?",
            style: AppStyles.textStyle20.copyWith(
              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
              color: Colors.black,
            ),
          ),
          Gap(8.h),
          Text(
            "Our team is available 24/7 to help you with your routine.",
            style: AppStyles.textStyle14.copyWith(
              fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
            ),
          ),
          Gap(24.h),
          CustomButton(
            text: "Contact Support",
            onTap: () => buildNotImplementedYetDialog(
              context,
              featureName: "Contact Support",
            ),
            backColor: AppColors.secondaryColor,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
