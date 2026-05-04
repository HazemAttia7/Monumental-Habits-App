import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pixel_true_app/features/community/data/models/post_model.dart';
import 'package:pixel_true_app/features/community/presentation/managers/posts_cubit/posts_cubit.dart';

import 'package:pixel_true_app/features/community/presentation/views/widgets/comments_count.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/toggle_post_like.dart';

class PostInteractions extends StatelessWidget {
  final Post post;
  const PostInteractions({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12.w,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TogglePostLike(
          postLikesCount: post.likesCount,
          isLiked: post.isLikedBy(
            BlocProvider.of<AuthCubit>(context).currentUser!.uid,
          ),
          toggleLike: () {
            context.read<PostsCubit>().toggleLike(
              post.id,
              BlocProvider.of<AuthCubit>(context).currentUser!.uid,
            );
          },
        ),
        CommentsCount(post: post),
      ],
    );
  }
}
