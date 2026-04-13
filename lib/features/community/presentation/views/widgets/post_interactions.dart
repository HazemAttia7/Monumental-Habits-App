import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pixel_true_app/features/community/presentation/views/widgets/comments_count.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/toggle_post_like.dart';

class PostInteractions extends StatelessWidget {
  final int postLikesCount, commentsCount;
  const PostInteractions({
    super.key,
    required this.postLikesCount,
    required this.commentsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12.w,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TogglePostLike(
          postLikesCount: postLikesCount,
          isLiked: false,
          onTap: () {
            // TODO : like post
          },
        ),
        CommentsCount(commentsCount: commentsCount),
      ],
    );
  }
}
