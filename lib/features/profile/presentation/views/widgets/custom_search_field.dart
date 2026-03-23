import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class CustomSearchField extends StatelessWidget {
  final void Function(String)? onChanged;
  const CustomSearchField({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        fillColor: AppColors.primaryColor.withValues(alpha: .1),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Padding(
          padding: EdgeInsetsDirectional.only(start: 16.w, end: 5.w),
          child: Icon(Icons.search, size: 22.sp),
        ),
        prefixIconConstraints: BoxConstraints(
          minWidth: 40.sp,
          minHeight: 40.sp,
        ),
        prefixIconColor: AppColors.secondaryColor.withValues(alpha: .7),
        hintText: "Search by habit name...",
        hintStyle: AppStyles.textStyle14.copyWith(
          color: AppColors.secondaryColor.withValues(alpha: .7),
        ),
      ),
    );
  }
}
