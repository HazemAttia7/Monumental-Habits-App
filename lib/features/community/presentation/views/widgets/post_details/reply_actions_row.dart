import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/custom_clickable_text.dart';
import 'package:pixel_true_app/features/community/data/models/reply_model.dart';
import 'package:pixel_true_app/features/community/helper/get_time_ago.dart';

class ReplyActionsRow extends StatelessWidget {
  final Function(Reply) onReplyTap;
  final bool showReplies;
  final Reply reply;
  const ReplyActionsRow({
    super.key,
    required this.onReplyTap,
    this.showReplies = false,
   required this.reply,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 12.w,
      children: [
        CustomClickableText(
          text: "REPLY",
          onTap:() => onReplyTap(reply) ,
          textColor: Color.lerp(AppColors.primaryColor, Colors.black, .35),
          fontSize: 12.sp,
        ),
        CustomClickableText(
          text: "LIKE",
          onTap: () {
            // TODO : like reply
          },
          textColor: AppColors.secondaryColor,
          fontSize: 12.sp,
        ),
        Text(
          getTimeAgo(DateTime.now().difference(reply.createdAt)),
          style: AppStyles.textStyle12,
        ),
      ],
    );
  }
}
