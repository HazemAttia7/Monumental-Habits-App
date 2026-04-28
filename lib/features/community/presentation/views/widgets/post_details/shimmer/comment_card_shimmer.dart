import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/widgets/shimmer/line_shimmer.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/shimmer/actions_row_shimmer.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/shimmer/comment_content_shimmer.dart';

class CommentCardShimmer extends StatelessWidget {
  const CommentCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LineShimmer(width: 45.w, height: 12.h),
          Gap(16.h),
          const CommentContentShimmer(),
          Gap(16.h),
          const ActionsRowShimmer(),
        ],
      ),
    );
  }
}
