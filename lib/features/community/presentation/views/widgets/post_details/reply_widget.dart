import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/widgets/profile_placeholder.dart';
import 'package:pixel_true_app/features/community/data/models/reply_model.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/reply_card.dart';

class ReplyWidget extends StatelessWidget {
  final Reply reply;
  final VoidCallback onReplyTap;

  const ReplyWidget({super.key, required this.reply, required this.onReplyTap});

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
        ReplyCard(onReplyTap: onReplyTap, reply: reply),
      ],
    );
  }
}
