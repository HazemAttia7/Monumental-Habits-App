import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final double? iconSize, elevation;
  final EdgeInsetsGeometry? padding;
  final Color? iconColor, backColor;
  final BoxShape? shape;
  const CustomIconButton({
    super.key,
    required this.onTap,
    required this.icon,
    this.iconSize,
    this.padding,
    this.iconColor,
    this.backColor,
    this.shape,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color:
          backColor ??
          iconColor?.withValues(alpha: .1) ??
          AppColors.secondaryColor.withValues(alpha: .1),
      shape: shape == BoxShape.circle ? null : const CircleBorder(),
      elevation: elevation ?? 0,
      shadowColor: AppColors.secondaryColor,
      child: InkWell(
        customBorder: shape == BoxShape.circle ? null : const CircleBorder(),
        highlightColor:
            iconColor?.withValues(alpha: .1) ??
            AppColors.secondaryColor.withValues(alpha: .1),
        splashColor:
            iconColor?.withValues(alpha: .1) ??
            AppColors.secondaryColor.withValues(alpha: .1),
        onTap: onTap,
        child: Container(
          padding: padding ?? EdgeInsets.all(11.sp),
          decoration: BoxDecoration(
            shape: shape ?? BoxShape.circle,
            borderRadius: shape == BoxShape.circle
                ? BorderRadius.circular(9999.r)
                : null,
          ),
          child: Icon(
            icon,
            color: iconColor ?? AppColors.secondaryColor,
            size: iconSize ?? 22.sp,
          ),
        ),
      ),
    );
  }
}
