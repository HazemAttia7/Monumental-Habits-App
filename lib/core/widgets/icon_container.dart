import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconContainer extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final double? iconSize;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  const IconContainer({
    super.key,
    required this.icon,
    required this.iconColor,
    this.iconSize,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.all(11.sp),
      decoration: BoxDecoration(
        shape: borderRadius == null ? BoxShape.circle : BoxShape.rectangle,
        color: iconColor.withValues(alpha: .15),
        borderRadius: borderRadius,
      ),
      child: Icon(icon, color: iconColor, size: iconSize ?? 22.sp),
    );
  }
}
