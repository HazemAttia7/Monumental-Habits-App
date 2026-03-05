import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class ClickableIconTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color themeColor;
  final double? iconSize;
  final VoidCallback onTap;
  const ClickableIconTextWidget({
    super.key,
    required this.icon,
    required this.text,
    required this.themeColor,
    this.iconSize,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(8.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(8.r),
        onTap: onTap,
        splashColor: themeColor.withValues(alpha: .1),
        highlightColor: themeColor.withValues(alpha: .1),
        child: Row(
          children: [
            Icon(icon, color: themeColor, size: iconSize ?? 16.sp),
            Gap(8.w),
            Expanded(
              child: Text(
                text,
                style: AppStyles.textStyle12.copyWith(
                  color: AppColors.primaryColor.withValues(alpha: .5),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
