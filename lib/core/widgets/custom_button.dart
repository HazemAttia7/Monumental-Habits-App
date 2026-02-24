import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isLoading;
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isLoading,
      child: Material(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(8.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(8.r),
          onTap: onTap,
          child: SizedBox(
            height: 60.h,
            child: Center(
              child: isLoading
                  ? const CircularProgressIndicator(
                      color: AppColors.scaffoldColor,
                    )
                  : Text(text, style: AppStyles.textStyle16),
            ),
          ),
        ),
      ),
    );
  }
}
