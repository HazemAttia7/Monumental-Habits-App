import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/features/auth/presentation/views/widgets/custom_list_tile.dart';

class SignInWithButton extends StatelessWidget {
  final String text;
  final String image;
  final VoidCallback onTap;
  final bool isLoading;
  const SignInWithButton({
    super.key,
    required this.text,
    required this.image,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isLoading,
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(12.r),
          onTap: onTap,
          child: SizedBox(
            height: 50.sp,
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  )
                : CustomListTile(
                    mainAxisAlignment: MainAxisAlignment.center,
                    leftPadding: 0,
                    leadingImage: image,
                    title: text,
                    spacing: 16.w,
                  ),
          ),
        ),
      ),
    );
  }
}
