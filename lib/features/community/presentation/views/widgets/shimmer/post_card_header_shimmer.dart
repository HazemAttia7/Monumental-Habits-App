import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/shimmer/user_meta_info_shimmer.dart';
import 'package:shimmer/shimmer.dart';

class PostCardHeaderShimmer extends StatelessWidget {
  const PostCardHeaderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [UserMetaInfoShimmer(), _ButtonShimmer()],
        ),
        Gap(12.h),
        Divider(color: Colors.grey.shade100, thickness: 2.w, height: 1),
        Gap(12.h),
      ],
    );
  }
}

class _ButtonShimmer extends StatelessWidget {
  const _ButtonShimmer();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: 40.h,
        width: 40.w,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
