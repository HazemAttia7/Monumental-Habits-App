import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isLoading;
  final double? height;
  final Color? backColor, textColor, splashColor, highlightColor;
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isLoading = false,
    this.height,
    this.backColor,
    this.textColor,
    this.splashColor,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isLoading,
      child: Material(
        color: backColor ?? AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(8.r),
        child: InkWell(
          splashColor:
              splashColor?.withValues(alpha: .1) ??
              textColor?.withValues(alpha: .1) ??
              AppColors.primaryColor.withValues(alpha: .1),
          highlightColor:
              highlightColor?.withValues(alpha: .1) ??
              textColor?.withValues(alpha: .1) ??
              AppColors.primaryColor.withValues(alpha: .1),
          borderRadius: BorderRadius.circular(8.r),
          onTap: onTap,
          child: SizedBox(
            height: height ?? 60.h,
            child: Center(
              child: isLoading
                  ? const CircularProgressIndicator(
                      color: AppColors.scaffoldColor,
                    )
                  : Text(
                      text,
                      style: AppStyles.textStyle16.copyWith(color: textColor),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
