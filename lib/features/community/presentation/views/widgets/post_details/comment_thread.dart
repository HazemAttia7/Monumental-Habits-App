import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/features/community/data/models/comment_model.dart';
import 'package:pixel_true_app/features/community/presentation/managers/comments_cubit/comments_cubit.dart';
import 'package:pixel_true_app/features/community/presentation/managers/edit_content_controller.dart';
import 'package:pixel_true_app/features/community/presentation/managers/post_details_view_controller.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/comment_card.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/edit_actions_row.dart';

class CommentThread extends StatelessWidget {
  const CommentThread({
    super.key,
    required this.comment,
    required this.showReplies,
    required this.onReplyTap,
    required this.onHideRepliesTap,
  });

  final Comment comment;
  final bool showReplies;
  final VoidCallback onReplyTap, onHideRepliesTap;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<PostDetailsViewController>();
    final editController = context.watch<EditContentController>();

    return Column(
      spacing: 8.h,
      children: [
        CommentCard(
          comment: comment,
          showReplies: showReplies,
          onReplyTap: onReplyTap,
          onHideRepliesTap: onHideRepliesTap,
        ),
        if (controller.isEditCommentMode &&
            comment.id == controller.commentIdToEdit)
          EditActionsRow(
            onConfirm: () => editController.submit((newContent) async {
              if (newContent == comment.content) return;
              await context.read<CommentsCubit>().editComment(
                comment.postId,
                comment.id,
                newContent,
              );
              controller.onDoneEditComment();
            }),
            isLoading: editController.isLoading,
          ),
      ],
    );
  }
}
