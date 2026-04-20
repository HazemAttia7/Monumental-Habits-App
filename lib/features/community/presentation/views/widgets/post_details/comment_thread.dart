import 'package:flutter/material.dart';
import 'package:pixel_true_app/features/community/data/models/comment_model.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/comment_card.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/replies_list.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/replies_teaser.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/reply_input.dart';

class CommentThread extends StatefulWidget {
  final Comment comment;
  const CommentThread({super.key, required this.comment});

  @override
  State<CommentThread> createState() => _CommentThreadState();
}

class _CommentThreadState extends State<CommentThread> {
  bool _showReplies = false;
  String? _replyingToUsername;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommentCard(
          comment: widget.comment,
          showReplies: _showReplies,
          onReplyTap: () => setState(() {
            _replyingToUsername = widget.comment.authorUsername;
            _showReplies = true;
          }),
          onViewRepliesTap: () => setState(() {
            _showReplies = false;
          }),
        ),
        if (!_showReplies)
          RepliesTeaser(
            onViewRepliesTap: () => setState(() {
              _showReplies = true;
            }),
          )
        else
          RepliesList(
            comment: widget.comment,
            onReplyTap: (username) => setState(() {
              _replyingToUsername = username;
            }),
            onDone: () => setState(() => _replyingToUsername = null),
          ),
        if (_replyingToUsername != null)
          ReplyInput(
            replyingToUsername: _replyingToUsername!,
            comment: widget.comment,
            onDone: () => setState(() => _replyingToUsername = null),
          ),
      ],
    );
  }
}
