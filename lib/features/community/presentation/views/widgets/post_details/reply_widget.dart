import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/widgets/profile_placeholder.dart';
import 'package:pixel_true_app/features/community/data/models/comment_model.dart';
import 'package:pixel_true_app/features/community/data/models/reply_model.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/reply_card.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/reply_input.dart';

// TODO : add remove , edit reply if current user is the author
class ReplyWidget extends StatelessWidget {
  final Reply reply;
  final VoidCallback onReplyTap;
  final VoidCallback onDone;
  final Comment comment;
  final String? replyingToUsername;

  const ReplyWidget({
    super.key,
    required this.reply,
    required this.onReplyTap,
    required this.onDone,
    required this.comment,
    required this.replyingToUsername,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfilePlaceholder(
          userName: reply.authorUsername,
          padding: EdgeInsets.all(2.sp),
          width: 30.w,
          height: 30.h,
          fontSize: 12.sp,
        ),
        Gap(8.w),
        Expanded(
          child: Column(
            children: [
              ReplyCard(onReplyTap: onReplyTap, reply: reply),
              Gap(8.h),
              if (replyingToUsername != null)
                ReplyInput(
                  replyingToUsername: replyingToUsername!,
                  comment: comment,
                  onDone: onDone,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
