import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/shimmer/line_shimmer.dart';

class PostContentShimmer extends StatelessWidget {
  const PostContentShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16.h,
      children: List.generate(3, (_) => const LineShimmer()),
    );
  }
}
