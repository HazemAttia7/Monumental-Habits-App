import 'package:flutter/material.dart';

class AnimatedSlideWidget extends StatelessWidget {
  final Widget child;
  final Duration transformDuration, opacityDuration;
  const AnimatedSlideWidget({
    super.key,
    required this.child,
    this.transformDuration = const Duration(seconds: 1),
    this.opacityDuration = const Duration(milliseconds: 250),
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Offset>(
      duration: transformDuration,
      tween: Tween(begin: const Offset(-100, 0), end: Offset.zero),
      curve: Curves.elasticOut,
      builder: (context, value, child) {
        return Transform.translate(
          offset: value,
          child: TweenAnimationBuilder<double>(
            duration: opacityDuration,
            tween: Tween(begin: 0.0, end: 1.0),
            curve: Curves.easeInOut,
            builder: (context, value, child) {
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
