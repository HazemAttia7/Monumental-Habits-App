import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_card_header.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_content.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_interactions.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: () {
          // TODO : navigate to post details
        },
        splashColor: AppColors.secondaryColor.withValues(alpha: .1),
        highlightColor: AppColors.secondaryColor.withValues(alpha: .1),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r)),
          child: const Column(
            children: [
              PostCardHeader(
                userName: 'Jerome',
                postedSince: Duration(minutes: 42),
              ),
              PostContent(
                content:
                    "Man, you're my new guru! Viewing the lessons for a second time. Thoroughly pleased. And impressed that you draw from scientific literature in telling memorable Man, you're my new guru! Viewing the lessons for a second time. Thoroughly pleased. And impressed that you draw from scientific literature in telling memorable",
              ),
              PostInteractions(),
            ],
          ),
        ),
      ),
    );
  }
}
