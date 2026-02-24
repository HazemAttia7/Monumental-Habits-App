import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/features/auth/presentation/views/widgets/custom_list_tile.dart';

class ContinueWithButton extends StatelessWidget {
  final String image;
  final String text;
  final VoidCallback onTap;
  final bool isLoading;
  const ContinueWithButton({
    super.key,
    required this.image,
    required this.text,
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
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 13.sp),
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  )
                : CustomListTile(leadingImage: image, title: text),
          ),
        ),
      ),
    );
  }
}
