import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';

abstract class AppStyles {
  static final textStyle32 = TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.primaryTextColor,
  );

  static final textStyle24 = TextStyle(fontSize: 24.sp);

  static final textStyle22 = TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeight.bold,
  );

  static final textStyle20 = TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.secondaryTextColor,
  );

  static final textStyle18 = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryTextColor,
  );

  static final textStyle17 = TextStyle(
    fontSize: 17.sp,
    fontWeight: FontWeight.bold,
  );

  static final textStyle16 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryTextColor,
  );

  static final textStyle14 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryTextColor,
  );

  static final textStyle12 = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryTextColor,
  );

  static final textStyle10 = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryTextColor,
  );

  static final textStyle8 = TextStyle(
    fontSize: 8.sp,
    fontWeight: FontWeight.w500,
  );
}
