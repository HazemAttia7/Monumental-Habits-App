import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/community/presentation/managers/comments_cubit/comments_cubit.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/add_comment_placeholder.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/comments_sliver_list.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/shimmer/comments_list_shimmer.dart';

class CommentsSection extends StatelessWidget {
  const CommentsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentsCubit, CommentsState>(
      builder: (context, state) => switch (state) {
        CommentsInitial() => const SliverToBoxAdapter(child: SizedBox.shrink()),
        CommentsLoading() => const SliverToBoxAdapter(
          child: CommentsListShimmer(),
        ),
        CommentsError(:final errMessage) => SliverFillRemaining(
          child: Center(child: Text(errMessage, style: AppStyles.textStyle17)),
        ),
        CommentsSuccess(:final comments) => SliverMainAxisGroup(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [const AddCommentPlaceholder(), Gap(18.h)],
              ),
            ),
            CommentsSliverList(comments: comments),
          ],
        ),
      },
    );
  }
}
