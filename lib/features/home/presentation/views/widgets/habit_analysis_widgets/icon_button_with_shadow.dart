import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconButtonWithShadow extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double? iconSize;
  final VoidCallback onTap;
  const IconButtonWithShadow({
    super.key,
    required this.icon,
    required this.color,
    this.iconSize,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        highlightColor: color.withValues(alpha: .1),
        splashColor: color.withValues(alpha: .1),
        onTap: () {},
        child: Center(
          child: Icon(
            icon,
            size: iconSize ?? 18.sp,
            shadows: [
              Shadow(
                color: color.withValues(alpha: .5),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
