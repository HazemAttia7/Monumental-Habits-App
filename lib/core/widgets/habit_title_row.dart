import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/icon_container.dart';

class HabitTitleRow extends StatelessWidget {
  final String habitName;
  final DateTime createdAt;
  final Color? themeColor, titleColor, subtitleColor;
  const HabitTitleRow({
    super.key,
    required this.habitName,
    required this.createdAt,
    this.themeColor,
    this.titleColor,
    this.subtitleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconContainer(
          icon: FontAwesomeIcons.cube,
          iconColor: themeColor ?? AppColors.primaryColor,
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
                habitName,
                style: AppStyles.textStyle18.copyWith(
                  fontFamily: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.bold,
                  ).fontFamily,
                  height: 1,
                  color: titleColor ?? AppColors.secondaryColor,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Gap(4.h),
              Text(
                "created at ${_getDate(createdAt)}".toUpperCase(),
                style: AppStyles.textStyle10.copyWith(
                  color: subtitleColor ?? themeColor ?? AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.bold,
                  ).fontFamily,
                  letterSpacing: 1.1,
                  height: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        Gap(12.w),
      ],
    );
  }

  String _getDate(DateTime date) => "${date.day}/${date.month}/${date.year}";
}
