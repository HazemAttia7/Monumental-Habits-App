import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_card_header.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_content.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_interactions.dart';

class PostCard extends StatelessWidget {
  final String userName, content;
  final Duration postedSince;
  final int commentsCount, postLikesCount;
  const PostCard({
    super.key,
    required this.userName,
    required this.content,
    required this.postedSince,
    required this.commentsCount,
    required this.postLikesCount,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(16.r),
        onTap: () {
          // TODO : navigate to post details
        },
        splashColor: AppColors.secondaryColor.withValues(alpha: .1),
        highlightColor: AppColors.secondaryColor.withValues(alpha: .1),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r)),
          child: Column(
            children: [
              PostCardHeader(userName: userName, postedSince: postedSince),
              PostContent(content: content),
              PostInteractions(
                postLikesCount: postLikesCount,
                commentsCount: commentsCount,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
