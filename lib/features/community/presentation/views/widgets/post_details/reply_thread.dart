import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/features/community/data/models/reply_model.dart';
import 'package:pixel_true_app/features/community/presentation/managers/community_view_controller.dart';
import 'package:pixel_true_app/features/community/presentation/managers/edit_content_controller.dart';
import 'package:pixel_true_app/features/community/presentation/managers/replies_cubit/replies_cubit.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/edit_actions_row.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/reply_card.dart';
import 'package:provider/provider.dart';

class ReplyThread extends StatelessWidget {
  final Function(Reply) onReplyToReplyTap;
  final Reply reply;
  const ReplyThread({
    super.key,
    required this.onReplyToReplyTap,
    required this.reply,
  });

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CommunityViewController>();
    final editController = context.watch<EditContentController>();
    return Column(
      spacing: 8.h,
      children: [
        ReplyCard(reply: reply, onReplyTap: onReplyToReplyTap),
        if (controller.isEditReplyMode && reply.id == controller.replyIdToEdit)
          EditActionsRow(
            onConfirm: () => editController.submit((newContent) async {
              if (newContent == reply.content) return;
              await context.read<RepliesCubit>().editReply(
                reply.postId,
                reply.commentId,
                reply.id,
                newContent,
              );
              controller.onDoneEditReply();
            }),
            isLoading: editController.isLoading,
          ),
      ],
    );
  }
}
