import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/features/community/data/models/reply_model.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/expandable_content.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/comment_reply_actions_row.dart';

class ReplyCard extends StatelessWidget {
  final Reply reply;
  final VoidCallback onReplyTap;

  const ReplyCard({
    super.key,
    required this.reply,
    required this.onReplyTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: 1.sw - 2 * kPagePadding.w - 52.w - 38.w,
      ),
      padding: EdgeInsets.all(8.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            reply.authorUsername,
            style: AppStyles.textStyle14.copyWith(fontWeight: FontWeight.bold),
          ),
          Gap(4.h),
          Wrap(
            children: [
              if (reply.replyToUsername != null)
                Text(
                  '@${reply.replyToUsername} ',
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ExpandableContent(
                content: reply.text,
                style: TextStyle(fontSize: 13.sp, color: Colors.black),
              ),
            ],
          ),
          Gap(8.h),
          CommentReplyActionsRow(
            onReplyTap: onReplyTap,
            createdAt: reply.createdAt,
          ),
          
        ],
      ),
    );
  }
}
