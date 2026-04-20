import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/widgets/profile_placeholder.dart';
import 'package:pixel_true_app/features/community/data/models/comment_model.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/comment_card.dart';

class CommentWhenCollapsed extends StatelessWidget {
  final Comment comment;
  final bool showReplies;
  final VoidCallback onReplyTap;
  const CommentWhenCollapsed({
    super.key,
    required this.comment,
    required this.showReplies,
    required this.onReplyTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfilePlaceholder(
          userName: comment.authorUsername,
          padding: EdgeInsets.all(12.sp),
        ),
        Gap(8.w),
        Expanded(
          child: CommentCard(
            comment: comment,
            showReplies: showReplies,
            onReplyTap: onReplyTap,
          ),
        ),
      ],
    );
  }
}
