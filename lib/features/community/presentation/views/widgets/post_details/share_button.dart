import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.only(bottomRight: Radius.circular(12.r)),
      child: InkWell(
        onTap: () {
          // TODO : implement share post
        },
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(12.r)),
        splashColor: AppColors.primaryColor.withValues(alpha: .1),
        highlightColor: AppColors.primaryColor.withValues(alpha: .1),
        child: Padding(
          padding: EdgeInsets.all(18.sp),
          child: Center(child: Icon(Icons.share_outlined, size: 24.sp)),
        ),
      ),
    );
  }
}
