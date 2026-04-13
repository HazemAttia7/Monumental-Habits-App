import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/shimmer/post_card_header_shimmer.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/shimmer/post_content_shimmer.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/shimmer/post_interactions_shimmer.dart';

class PostCardShimmer extends StatelessWidget {
  const PostCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PostCardHeaderShimmer(),
          Gap(8.h),
          const PostContentShimmer(),
          Gap(12.h),
          const PostInteractionsShimmer(),
        ],
      ),
    );
  }
}
