import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class DeleteDialogHeader extends StatelessWidget {
  final String itemType;
  final IconData headerIcon;
  final String? headerText;
  final double? headerIconSize;
  final EdgeInsets? headerIconPadding;
  const DeleteDialogHeader({
    super.key,
    required this.itemType,
    required this.headerIcon,
    this.headerIconSize,
    this.headerIconPadding,
    this.headerText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.secondaryColor, AppColors.primaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: headerIconPadding ?? EdgeInsets.all(12.sp),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              headerIcon,
              color: Colors.white,
              size: headerIconSize ?? 28.sp,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            headerText ?? 'Delete ${_capitalize(itemType)}',
            style: AppStyles.textStyle16.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ),
        ],
      ),
    );
  }

  String _capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
}
