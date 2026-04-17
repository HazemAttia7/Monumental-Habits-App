import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/comment_widget.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/comments_section_header.dart';

class CommentsSection extends StatelessWidget {
  const CommentsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CommentsSectionHeader(),
        Gap(24.h),
        const CommentWidget(),
        Gap(24.h),
      ],
    );
  }
}
