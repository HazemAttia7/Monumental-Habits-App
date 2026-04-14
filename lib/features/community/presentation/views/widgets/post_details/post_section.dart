import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/features/community/data/models/post_model.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_content.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/actions_row.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/interactions_info_row.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/user_meta_info_row.dart';

class PostSection extends StatelessWidget {
  const PostSection({super.key});

  @override
  Widget build(BuildContext context) {
    final post = GoRouterState.of(context).extra as Post;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Gap(16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: UserMetaInfoRow(
              userName: post.authorUsername,
              createdAt: post.createdAt,
            ),
          ),
          Gap(24.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: PostContent(content: post.content, maxLines: 20),
          ),
          Gap(18.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: const InteractionsInfoRow(),
          ),
          Gap(8.h),
          Divider(
            color: AppColors.secondaryColor.withValues(alpha: .3),
            thickness: 1.sp,
            height: 1,
          ),
          const ActionsRow(),
        ],
      ),
    );
  }
}
