import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/features/community/data/models/comment_model.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/expandable_content.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/comment_actions_row.dart';

// TODO : add the three dots menu to edit/delete the comment if current user is the author
class CommentCard extends StatelessWidget {
  final Comment comment;
  final VoidCallback onReplyTap, onHideRepliesTap;
  final bool showReplies;
  const CommentCard({
    super.key,
    required this.comment,
    required this.onReplyTap,
    required this.onHideRepliesTap,
    required this.showReplies,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 1.sw - 2 * kPagePadding.w - 52.w),
      padding: EdgeInsets.only(
        top: 6.h,
        bottom: 12.sp,
        left: 12.w,
        right: 12.w,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            comment.authorUsername,
            style: AppStyles.textStyle14.copyWith(fontWeight: FontWeight.bold),
          ),
          Gap(4.h),
          ExpandableContent(
            content: comment.content,
            style: AppStyles.textStyle14.copyWith(color: Colors.black),
          ),
          Gap(8.h),
          CommentActionsRow(
            onReplyTap: onReplyTap,
            onHideRepliesTap: onHideRepliesTap,
            showReplies: showReplies,
            createdAt: comment.createdAt,
          ),
        ],
      ),
    );
  }
}
