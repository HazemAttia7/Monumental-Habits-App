import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';

class HelpButton extends StatelessWidget {
  const HelpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // show alert dialog
      },
      child: Container(
        padding: EdgeInsets.all(11.sp),
        foregroundDecoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primaryColor.withValues(alpha: .1),
        ),
        child: Icon(
          FontAwesomeIcons.question,
          color: AppColors.primaryColor,
          size: 22.sp,
        ),
      ),
    );
  }
}
