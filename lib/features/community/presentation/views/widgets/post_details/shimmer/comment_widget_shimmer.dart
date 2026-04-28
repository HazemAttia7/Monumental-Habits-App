import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/shimmer/comment_card_shimmer.dart';
import 'package:shimmer/shimmer.dart';

class CommentWidgetShimmer extends StatelessWidget {
  const CommentWidgetShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            width: 48.w,
            height: 48.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade300,
            ),
          ),
        ),
        Gap(8.w),
        const Expanded(child: CommentCardShimmer()),
      ],
    );
  }
}
