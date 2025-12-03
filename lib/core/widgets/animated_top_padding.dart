import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAnimatedTopPadding extends StatelessWidget {
  final Widget child;
  final double padding;
  final Duration duration;
  const CustomAnimatedTopPadding({
    super.key,
    required this.child,
    required this.padding,
    this.duration = const Duration(milliseconds: 1200),
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: duration,
      curve: Curves.fastEaseInToSlowEaseOut,
      builder: (context, double value, Widget? child) {
        return Padding(
          padding: EdgeInsets.only(top: (1 - value) * padding.sp),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: child,
    );
  }
}
