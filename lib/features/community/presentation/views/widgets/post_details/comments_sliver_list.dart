import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/community/data/models/comment_model.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/comment_widget.dart';

class CommentsSliverList extends StatelessWidget {
  final List<Comment> comments;
  const CommentsSliverList({super.key, required this.comments});

  @override
  Widget build(BuildContext context) {
    return comments.isEmpty
        ? SliverFillRemaining(
            child: Center(
              child: Text('No comments yet!', style: AppStyles.textStyle17),
            ),
          )
        : SliverList.separated(
            itemCount: comments.length,
            separatorBuilder: (_, __) => Gap(18.h),
            itemBuilder: (_, index) => CommentWidget(comment: comments[index]),
          );
  }
}
