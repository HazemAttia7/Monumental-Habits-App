import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconContainer extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color? backColor;
  final double? iconSize;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  const IconContainer({
    super.key,
    required this.icon,
    required this.iconColor,
    this.iconSize,
    this.padding,
    this.borderRadius,
    this.backColor,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.all(11.sp),
      decoration: BoxDecoration(
        shape: borderRadius == null ? BoxShape.circle : BoxShape.rectangle,
        color: backColor ?? iconColor.withValues(alpha: .15),
        borderRadius: borderRadius,
        boxShadow: boxShadow,
      ),
      child: Icon(icon, color: iconColor, size: iconSize ?? 22.sp),
    );
  }
}
