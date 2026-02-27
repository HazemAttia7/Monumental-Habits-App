import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final Color color;
  final double width, height, margin;
  final BorderRadius? borderRadius;
  const CustomDivider({
    super.key,
    required this.color,
    required this.width,
    required this.height,
    required this.margin,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.symmetric(horizontal: margin),
      decoration: BoxDecoration(color: color, borderRadius: borderRadius),
    );
  }
}
