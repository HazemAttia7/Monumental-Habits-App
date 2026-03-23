import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class IconTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color themeColor;
  final double? iconSize;
  const IconTextWidget({
    super.key,
    required this.icon,
    required this.text,
    required this.themeColor,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: themeColor, size: iconSize ?? 16.sp),
        Gap(8.w),
        Expanded(
          child: Text(
            text,
            style: AppStyles.textStyle12.copyWith(
              color: AppColors.secondaryColor.withValues(alpha: .5),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
