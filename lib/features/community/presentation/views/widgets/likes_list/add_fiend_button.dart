import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class AddFriendButton extends StatelessWidget {
  const AddFriendButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primaryColor,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: () {
          // TODO : implement add friend
        },
        borderRadius: BorderRadius.circular(12.r),
        splashColor: AppColors.secondaryColor.withValues(alpha: .1),
        highlightColor: AppColors.secondaryColor.withValues(alpha: .1),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 6.sp),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r)),
          child: Text(
            "ADD FRIEND",
            style: AppStyles.textStyle14.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
