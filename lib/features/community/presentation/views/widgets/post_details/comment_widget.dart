import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/widgets/profile_placeholder.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/comment_card.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfilePlaceholder(
          userName: "Hazem",
          width: 40.w,
          height: 40.h,
          padding: EdgeInsets.all(2.sp),
        ),
        Gap(12.w),
        const CommentCard(),
      ],
    );
  }
}
