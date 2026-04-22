import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/custom_clickable_text.dart';
import 'package:pixel_true_app/features/community/helper/get_time_ago.dart';

class CommentActionsRow extends StatelessWidget {
  final VoidCallback onReplyTap, onHideRepliesTap;
  final bool showReplies;
  final DateTime createdAt;
  const CommentActionsRow({
    super.key,
    required this.onReplyTap,
    required this.onHideRepliesTap,
    this.showReplies = false,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 12.w,
      children: [
        CustomClickableText(
          text: "REPLY",
          onTap: onReplyTap,
          textColor: Color.lerp(AppColors.primaryColor, Colors.black, .35),
          fontSize: 12.sp,
        ),
        CustomClickableText(
          text: "LIKE",
          onTap: () {
            // TODO : like comment
          },
          textColor: AppColors.secondaryColor,
          fontSize: 12.sp,
        ),
        Text(
          getTimeAgo(DateTime.now().difference(createdAt)),
          style: AppStyles.textStyle12,
        ),
        if (showReplies)
          CustomClickableText(
            onTap: onHideRepliesTap,
            text: "Hide Replies",
            textColor: AppColors.secondaryColor,
            fontSize: 12.sp,
            textDecoration: TextDecoration.underline,
          ),
      ],
    );
  }
}
