import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';

class IconTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color themeColor;
  final Color? textColor;
  final double? iconSize, fontSize;
  final FontWeight? fontWeight;
  const IconTextWidget({
    super.key,
    required this.icon,
    required this.text,
    required this.themeColor,
    this.iconSize,
    this.fontSize,
    this.textColor,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: themeColor, size: iconSize ?? 16.sp),
        Gap(8.w),
        Flexible(
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize ?? 12.sp,
              fontWeight: fontWeight ?? FontWeight.w500,
              color:
                  textColor ?? AppColors.secondaryColor.withValues(alpha: .5),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
