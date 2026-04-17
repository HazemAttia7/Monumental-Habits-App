import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/community/presentation/managers/comments_cubit/comments_cubit.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/comment_widget.dart';

class CommentsSliverList extends StatelessWidget {
  const CommentsSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentsCubit, CommentsState>(
      builder: (context, state) {
        if (state is CommentsLoading) {
          // TODO: show shimmer comments list
          return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is CommentsSuccess) {
          final comments = state.comments;
          return comments.isEmpty
              ? SliverFillRemaining(
                  child: Center(
                    child: Text(
                      'No comments found !',
                      style: AppStyles.textStyle17,
                    ),
                  ),
                )
              : SliverList.separated(
                  itemCount: comments.length,
                  separatorBuilder: (_, __) => Gap(12.h),
                  itemBuilder: (_, index) {
                    return CommentWidget(comment: comments[index]);
                  },
                );
        }

        if (state is CommentsError) {
          return SliverFillRemaining(
            child: Center(
              child: Text(
                'Error loading comments',
                style: AppStyles.textStyle17,
              ),
            ),
          );
        }

        return const SliverToBoxAdapter(child: SizedBox());
      },
    );
  }
}
