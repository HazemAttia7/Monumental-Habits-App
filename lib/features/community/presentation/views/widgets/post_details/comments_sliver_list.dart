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
      builder: (context, state) => switch (state) {
        CommentsInitial() => const SliverToBoxAdapter(child: SizedBox.shrink()),
        CommentsLoading() => const SliverToBoxAdapter(
          // TODO : make it shimmer
          child: Center(child: CircularProgressIndicator()),
        ),
        CommentsError(:final errMessage) => SliverFillRemaining(
          child: Center(child: Text(errMessage, style: AppStyles.textStyle17)),
        ),
        CommentsSuccess(:final comments) =>
          comments.isEmpty
              ? SliverFillRemaining(
                  child: Center(
                    child: Text(
                      'No comments yet!',
                      style: AppStyles.textStyle17,
                    ),
                  ),
                )
              : SliverList.separated(
                  itemCount: comments.length,
                  separatorBuilder: (_, __) => Gap(18.h),
                  itemBuilder: (_, index) =>
                      CommentWidget(comment: comments[index]),
                ),
      },
    );
  }
}
