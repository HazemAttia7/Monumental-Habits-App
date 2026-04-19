import 'package:flutter/material.dart';
import 'package:pixel_true_app/features/community/data/models/comment_model.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/replies_list.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/reply_input.dart';

class RepliesSection extends StatelessWidget {
  final Comment comment;
  final String? replyingToUsername;
  final VoidCallback onDone;
  final void Function(String username) onReplyTap;

  const RepliesSection({
    super.key,
    required this.comment,
    this.replyingToUsername,
    required this.onDone,
    required this.onReplyTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RepliesList(onReplyTap: onReplyTap),
        if (replyingToUsername != null)
          ReplyInput(
            replyingToUsername: replyingToUsername!,
            comment: comment,
            onDone: onDone,
          ),
      ],
    );
  }
}
