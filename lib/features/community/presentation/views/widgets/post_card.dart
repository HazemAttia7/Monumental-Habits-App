import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_router.dart';
import 'package:pixel_true_app/features/community/data/models/post_model.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_card_header.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_content.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_interactions.dart';

class PostCard extends StatelessWidget {
  final Post post;
  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(16.r),
        onTap: () =>
            GoRouter.of(context).push(AppRouter.kPostDetailsView, extra: post),
        splashColor: AppColors.secondaryColor.withValues(alpha: .1),
        highlightColor: AppColors.secondaryColor.withValues(alpha: .1),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r)),
          child: Column(
            children: [
              PostCardHeader(
                userName: post.authorUsername,
                postedSince: _getPostedSinceDuration(),
              ),
              PostContent(content: post.content),
              PostInteractions(post: post),
            ],
          ),
        ),
      ),
    );
  }

  Duration _getPostedSinceDuration() {
    final now = DateTime.now();
    final difference = now.difference(post.createdAt);
    if (difference.inDays > 0) {
      return Duration(days: difference.inDays);
    } else if (difference.inHours > 0) {
      return Duration(hours: difference.inHours);
    } else if (difference.inMinutes > 0) {
      return Duration(minutes: difference.inMinutes);
    } else {
      return Duration(seconds: difference.inSeconds);
    }
  }
}
