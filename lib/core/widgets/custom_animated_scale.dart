import 'package:flutter/material.dart';

class CustomAnimatedScale extends StatelessWidget {
  final Widget child;
  final Duration scaleDuration , opacityDuration;
  const CustomAnimatedScale({super.key, required this.child,  this.scaleDuration = const Duration(milliseconds: 600) , this.opacityDuration = const Duration(milliseconds: 650)});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: scaleDuration,
      curve: Curves.easeInOutExpo,
      builder: (context, double value, Widget? child) {
        return Transform.scale(
          scale: value,
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: 1),
            duration: opacityDuration,
            curve: Curves.easeInOut,
            builder: (context, double value, Widget? child) {
              return Opacity(opacity: value, child: child);
            },
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
