import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/widgets/shimmer/line_shimmer.dart';

class PostSectionHeaderShimmer extends StatelessWidget {
  const PostSectionHeaderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 48.h,
          width: 48.w,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            shape: BoxShape.circle,
          ),
        ),
        Gap(12.w),
        Column(
          spacing: 4.h,
          children: [
            LineShimmer(width: 85.w, height: 12.h),
            LineShimmer(width: 50.w, height: 12.h),
          ],
        ),
      ],
    );
  }
}
