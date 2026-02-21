import 'package:flutter/material.dart';

class RoundedBottomLeftTriangle extends StatelessWidget {
  final Color color;
  final double? width, height;
  const RoundedBottomLeftTriangle({
    super.key,
    required this.color,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: RoundedBottomLeftTriangleClipper(),
      child: Container(width: width ?? 50, height: height ?? 50, color: color),
    );
  }
}

class RoundedBottomLeftTriangleClipper extends CustomClipper<Path> {
  final double radius;

  RoundedBottomLeftTriangleClipper({this.radius = 12});

  @override
  Path getClip(Size size) {
    final r = radius;

    Path path = Path();

    // Start near bottom-left
    path.moveTo(0, size.height - r);

    // Bottom-left corner
    path.quadraticBezierTo(0, size.height, r, size.height);

    // Bottom edge to near bottom-right
    path.lineTo(size.width - r, size.height);

    // Bottom-right rounding
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - r,
      size.height - r,
    );

    // Diagonal edge
    path.lineTo(r, r);

    // Top-left rounding
    path.quadraticBezierTo(0, 0, 0, r);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
