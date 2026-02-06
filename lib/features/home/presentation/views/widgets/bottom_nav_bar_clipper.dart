import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 414.sp;
    final double _yScaling = size.height / 80.sp;
    path.lineTo(0 * _xScaling, 0 * _yScaling);
    path.cubicTo(
      0 * _xScaling,
      0 * _yScaling,
      120.062 * _xScaling,
      0 * _yScaling,
      120.062 * _xScaling,
      0 * _yScaling,
    );
    path.cubicTo(
      137.706 * _xScaling,
      0 * _yScaling,
      155.036 * _xScaling,
      4.66836 * _yScaling,
      170.293 * _xScaling,
      13.5312 * _yScaling,
    );
    path.cubicTo(
      170.293 * _xScaling,
      13.5312 * _yScaling,
      188.741 * _xScaling,
      24.248 * _yScaling,
      188.741 * _xScaling,
      24.248 * _yScaling,
    );
    path.cubicTo(
      200.191 * _xScaling,
      30.8995 * _yScaling,
      214.323 * _xScaling,
      30.9249 * _yScaling,
      225.797 * _xScaling,
      24.3143 * _yScaling,
    );
    path.cubicTo(
      225.797 * _xScaling,
      24.3143 * _yScaling,
      244.825 * _xScaling,
      13.3518 * _yScaling,
      244.825 * _xScaling,
      13.3518 * _yScaling,
    );
    path.cubicTo(
      260.008 * _xScaling,
      4.60433 * _yScaling,
      277.223 * _xScaling,
      0 * _yScaling,
      294.746 * _xScaling,
      0 * _yScaling,
    );
    path.cubicTo(
      294.746 * _xScaling,
      0 * _yScaling,
      414 * _xScaling,
      0 * _yScaling,
      414 * _xScaling,
      0 * _yScaling,
    );
    path.cubicTo(
      414 * _xScaling,
      0 * _yScaling,
      414 * _xScaling,
      80 * _yScaling,
      414 * _xScaling,
      80 * _yScaling,
    );
    path.cubicTo(
      414 * _xScaling,
      80 * _yScaling,
      0 * _xScaling,
      80 * _yScaling,
      0 * _xScaling,
      80 * _yScaling,
    );
    path.cubicTo(
      0 * _xScaling,
      80 * _yScaling,
      0 * _xScaling,
      0 * _yScaling,
      0 * _xScaling,
      0 * _yScaling,
    );
    path.cubicTo(
      0 * _xScaling,
      0 * _yScaling,
      0 * _xScaling,
      0 * _yScaling,
      0 * _xScaling,
      0 * _yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
