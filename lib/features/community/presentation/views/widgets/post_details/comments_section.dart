import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/enums/community_enums.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/community/presentation/managers/comments_cubit/comments_cubit.dart';
import 'package:pixel_true_app/features/community/presentation/managers/post_details_view_controller.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/add_comment_placeholder.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/comments_sliver_list.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/shimmer/comments_list_shimmer.dart';

class CommentsSection extends StatelessWidget {
  const CommentsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<PostDetailsViewController>();
    return BlocBuilder<CommentsCubit, CommentsState>(
      builder: (context, state) {
        if (state is CommentsInitial) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        } else if (state is CommentsLoading) {
          return const SliverToBoxAdapter(child: CommentsListShimmer());
        } else if (state is CommentsError) {
          return SliverFillRemaining(
            child: Center(
              child: Text(state.errMessage, style: AppStyles.textStyle17),
            ),
          );
        } else if (state is CommentsSuccess) {
          final comments = switch (controller.commentsFilterBy) {
            enCommentsFilterBy.newest => state.newestComments,
            enCommentsFilterBy.oldest => state.oldestComments,
            enCommentsFilterBy.mostLiked => state.mostLikedComments,
          };
          return SliverMainAxisGroup(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [const AddCommentPlaceholder(), Gap(18.h)],
                ),
              ),
              CommentsSliverList(comments: comments),
            ],
          );
        }
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}
