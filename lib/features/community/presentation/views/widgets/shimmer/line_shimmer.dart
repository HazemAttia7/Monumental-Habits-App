import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class LineShimmer extends StatelessWidget {
  final double? width, height;
  const LineShimmer({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: height ?? 8.h,
        width: width ?? double.infinity,
        decoration: _decoration(),
      ),
    );
  }

  BoxDecoration _decoration() => BoxDecoration(
    color: Colors.grey.shade300,
    borderRadius: BorderRadius.circular(9999.r),
  );
}
