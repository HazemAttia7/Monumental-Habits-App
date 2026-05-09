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
  final BorderRadius? borderRadius;

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
    this.borderRadius,
  });

  bool get _isCircle => (shape ?? BoxShape.circle) == BoxShape.circle;

  BorderRadius get _resolvedRadius =>
      borderRadius ?? BorderRadius.circular(12.r);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backColor ??
          iconColor?.withValues(alpha: .1) ??
          AppColors.secondaryColor.withValues(alpha: .1),
      shape: _isCircle
          ? const CircleBorder()
          : RoundedRectangleBorder(borderRadius: _resolvedRadius),
      elevation: elevation ?? 0,
      shadowColor: AppColors.secondaryColor,
      child: InkWell(
        customBorder: _isCircle
            ? const CircleBorder()
            : RoundedRectangleBorder(borderRadius: _resolvedRadius),
        highlightColor: iconColor?.withValues(alpha: .1) ??
            AppColors.secondaryColor.withValues(alpha: .1),
        splashColor: iconColor?.withValues(alpha: .1) ??
            AppColors.secondaryColor.withValues(alpha: .1),
        onTap: onTap,
        child: Container(
          padding: padding ?? EdgeInsets.all(11.sp),
          decoration: BoxDecoration(
            shape: shape ?? BoxShape.circle,
            borderRadius: _isCircle ? null : _resolvedRadius,
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