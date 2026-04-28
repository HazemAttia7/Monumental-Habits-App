import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/widgets/shimmer/line_shimmer.dart';

class ActionsRowShimmer extends StatelessWidget {
  const ActionsRowShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12.w,
      children: List.generate(3, (index) => LineShimmer(width: 30.w)),
    );
  }
}
