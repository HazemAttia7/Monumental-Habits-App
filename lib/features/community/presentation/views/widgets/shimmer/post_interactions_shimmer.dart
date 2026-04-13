import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/shimmer/comments_shimmer.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/shimmer/like_shimmer.dart';

class PostInteractionsShimmer extends StatelessWidget {
  const PostInteractionsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12.w,
      mainAxisAlignment: MainAxisAlignment.end,
      children: const [LikeShimmer(), CommentsShimmer()],
    );
  }
}
