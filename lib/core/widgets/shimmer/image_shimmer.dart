import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ImageShimmer extends StatelessWidget {
  final double height, borderRadius;
  const ImageShimmer({
    super.key,
    required this.height,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.white,
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: Colors.grey.shade300,
        ),
      ),
    );
  }
}
