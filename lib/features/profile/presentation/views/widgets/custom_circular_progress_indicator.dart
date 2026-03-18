import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final int value;
  final Color color;
  const CustomCircularProgressIndicator({
    super.key,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color.withValues(alpha: .1), width: 3.w),
      ),
      child: CircularProgressIndicator(
        value: (value.toDouble() / 7),
        color: color,
        strokeWidth: 3.w,
        strokeAlign: 1,
        strokeCap: StrokeCap.round,
      ),
    );
  }
}
