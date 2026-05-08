import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/widgets/shimmer/line_shimmer.dart';

class PostContentShimmer extends StatelessWidget {
  const PostContentShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(
        3,
        (index) => Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: LineShimmer(width: double.infinity, height: 12.h),
        ),
      ),
    );
  }
}
