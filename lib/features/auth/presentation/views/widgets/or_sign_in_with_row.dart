import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class OrSignInWithRow extends StatelessWidget {
  const OrSignInWithRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10.w,
      children: [
        Expanded(
          child: Divider(color: AppColors.primaryColor.withValues(alpha: .2)),
        ),
        Text(
          "Or sign in with",
          style: AppStyles.textStyle14.copyWith(
            color: AppColors.primaryColor.withValues(alpha: .5),
          ),
        ),
        Expanded(
          child: Divider(color: AppColors.primaryColor.withValues(alpha: .2)),
        ),
      ],
    );
  }
}
