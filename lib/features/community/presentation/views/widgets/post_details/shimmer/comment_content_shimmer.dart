import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/widgets/shimmer/line_shimmer.dart';

class CommentContentShimmer extends StatelessWidget {
  const CommentContentShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8.h,
      children: List.generate(3, (index) => const LineShimmer()),
    );
  }
}
