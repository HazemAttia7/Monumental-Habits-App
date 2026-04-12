import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class ProfilePlaceholder extends StatelessWidget {
  final double? width, height, fontSize;
  final String userName;
  final EdgeInsets? padding;
  const ProfilePlaceholder({
    super.key,
    this.width,
    this.height,
    this.fontSize,
    required this.userName,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding ?? EdgeInsets.all(11.sp),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.secondaryColor,
      ),
      child: Center(
        child: Text(
          userName.substring(0, 2).toUpperCase(),
          style: AppStyles.textStyle16.copyWith(
            color: AppColors.scaffoldColor,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
