import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/icon_container.dart';

class HabitTitleRow extends StatelessWidget {
  const HabitTitleRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconContainer(
          icon: FontAwesomeIcons.cube,
          iconColor: AppColors.primaryColor,
          padding: EdgeInsets.all(14.sp),
          iconSize: 24.sp,
        ),
        Gap(12.w),
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Read A Book",
                style: AppStyles.textStyle18.copyWith(
                  fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                  height: 1,
                  color: AppColors.secondaryColor,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Gap(4.h),
              Text(
                "Created At 6/2023".toUpperCase(),
                style: AppStyles.textStyle10.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                  letterSpacing: 1.1,
                  height: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
