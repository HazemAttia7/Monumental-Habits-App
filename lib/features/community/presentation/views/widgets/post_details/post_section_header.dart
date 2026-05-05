import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pixel_true_app/features/community/data/models/post_model.dart';
import 'package:pixel_true_app/features/community/presentation/managers/community_view_controller.dart';
import 'package:pixel_true_app/features/community/presentation/managers/posts_cubit/posts_cubit.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/three_dots.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/user_meta_info_row.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/delete_dialog.dart';
import 'package:provider/provider.dart';

class PostSectionHeader extends StatelessWidget {
  const PostSectionHeader({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        UserMetaInfoRow(
          userName: post.authorUsername,
          createdAt: post.createdAt,
        ),
        if (post.authorUid == context.read<AuthCubit>().currentUser!.uid)
          Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: ThreeDots(
              onEditTap: () {
                GoRouter.of(context).pop();
                context.read<CommunityViewController>().onEditPostTap(post.id);
              },
              onDeleteTap: () {
                GoRouter.of(context).pop();
                showDialog(
                  context: context,
                  builder: (dialogContext) => DeleteDialog(
                    itemLabel: "this post",
                    onDelete: () {
                      GoRouter.of(dialogContext).pop();
                      context.read<PostsCubit>().deletePost(post);
                      GoRouter.of(context).pop();
                    },
                    headerIcon: Icons.delete,
                    collectionLabel: 'posts',
                    itemType: 'post',
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
