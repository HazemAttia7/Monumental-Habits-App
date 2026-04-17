import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/comment_actions_row.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({super.key});

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
        spacing: 4.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hazem",
            style: AppStyles.textStyle14.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            "I think I know exactly where this is! Is it the one near the old library? The shadows there are always so poetic.",
            style: AppStyles.textStyle14.copyWith(color: Colors.black),
          ),
          Gap(4.h),
          const CommentActionsRow(),
        ],
      ),
    );
  }
}
