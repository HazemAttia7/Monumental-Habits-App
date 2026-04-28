import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/widgets/profile_placeholder.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pixel_true_app/features/community/data/models/comment_model.dart';
import 'package:pixel_true_app/features/community/data/models/reply_model.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/comment_thread.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/reply_card.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/reply_input.dart';
import 'package:provider/provider.dart';

class RepliesTree extends StatelessWidget {
  final Comment comment;
  final List<Reply> displayReplies;
  final String? replyingToUsername;
  final VoidCallback onHideRepliesTap, onDone, onReplyTap;
  final Function(Reply) onReplyToReplyTap;
  const RepliesTree({
    super.key,
    required this.comment,
    required this.displayReplies,
    required this.replyingToUsername,
    required this.onReplyToReplyTap,
    required this.onHideRepliesTap,
    required this.onDone,
    required this.onReplyTap,
  });

  @override
  Widget build(BuildContext context) {
    return CommentTreeWidget<Comment, Reply>(
      comment,
      displayReplies,
      treeThemeData: const TreeThemeData(
        lineColor: AppColors.secondaryColor,
        lineWidth: 2,
      ),

      /// 🔵 ROOT AVATAR
      avatarRoot: (context, data) => PreferredSize(
        preferredSize: Size(40.w, 40.h),
        child: ProfilePlaceholder(
          userName: data.authorUsername,
          backColor:
              comment.authorUid == context.read<AuthCubit>().currentUser!.uid
              ? AppColors.primaryColor
              : null,
          padding: EdgeInsets.all(12.sp),
        ),
      ),

      /// 🔵 CHILD AVATAR
      avatarChild: (context, reply) => PreferredSize(
        preferredSize: Size(34.w, 34.h),
        child: ProfilePlaceholder(
          userName: reply.authorUsername,
          backColor:
              reply.authorUid == context.read<AuthCubit>().currentUser!.uid
              ? AppColors.primaryColor
              : null,
          padding: EdgeInsets.all(8.sp),
        ),
      ),

      /// 🟢 ROOT CONTENT
      contentRoot: (context, data) {
        return CommentThread(
          comment: data,
          showReplies: true,
          onHideRepliesTap: onHideRepliesTap,
          onReplyTap: onReplyTap,
        );
      },

      /// 🟢 CHILD CONTENT (Replies + Input)
      contentChild: (context, data) {
        final isTyping = data.id == '__typing__';

        /// FAKE INPUT NODE
        if (isTyping && replyingToUsername != null) {
          return ReplyInput(
            replyingToUsername: replyingToUsername!,
            comment: comment,
            onDone: onDone,
          );
        }

        /// 🔹 NORMAL REPLY
        return Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: ReplyCard(reply: data, onReplyTap: onReplyToReplyTap),
        );
      },
    );
  }
}
