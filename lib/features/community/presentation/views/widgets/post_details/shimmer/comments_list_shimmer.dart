import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/shimmer/comment_widget_shimmer.dart';

class CommentsListShimmer extends StatelessWidget {
  const CommentsListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 18.h,
      children: List.generate(3, (index) => const CommentWidgetShimmer()),
    );
  }
}
