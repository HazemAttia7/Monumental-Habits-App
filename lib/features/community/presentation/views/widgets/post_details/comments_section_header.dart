import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/enums/community_enums.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/custom_clickable_text.dart';
import 'package:pixel_true_app/features/community/presentation/managers/post_details_view_controller.dart';
import 'package:provider/provider.dart';

class CommentsSectionHeader extends StatelessWidget {
  const CommentsSectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<PostDetailsViewController>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Comments",
          style: AppStyles.textStyle20.copyWith(
            color: AppColors.secondaryColor.withValues(alpha: .8),
          ),
        ),
        CustomClickableText(
          text: _getSortText(controller.commentsFilterBy),
          fontSize: 14.sp,
          textColor: Color.lerp(AppColors.primaryColor, Colors.black, .25),
          onTap: controller.onSortCommentsTap,
        ),
      ],
    );
  }

  String _getSortText(enCommentsFilterBy filterBy) {
    switch (filterBy) {
      case enCommentsFilterBy.newest:
        return "Newest First";
      case enCommentsFilterBy.oldest:
        return "Oldest First";
      case enCommentsFilterBy.mostLiked:
        return "Most Liked";
    }
  }
}
