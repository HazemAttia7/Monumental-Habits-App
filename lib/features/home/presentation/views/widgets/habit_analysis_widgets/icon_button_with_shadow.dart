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
    final size = iconSize ?? 18.sp;
    final buttonSize = size + 12.r;
    return SizedBox(
      width: buttonSize,
      height: buttonSize,
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          highlightColor: color.withValues(alpha: .1),
          splashColor: color.withValues(alpha: .1),
          onTap: onTap,
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
      ),
    );
  }
}
