import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pixel_true_app/features/community/data/models/comment_model.dart';
import 'package:pixel_true_app/features/community/presentation/managers/post_details_view_controller.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/three_dots.dart';
import 'package:provider/provider.dart';

class CommentCardHeader extends StatelessWidget {
  final Comment comment;
  const CommentCardHeader({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    final currentUserUid = context.read<AuthCubit>().currentUser!.uid;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _getAuthorName(context, currentUserUid: currentUserUid),
          style: AppStyles.textStyle14.copyWith(fontWeight: FontWeight.bold),
        ),
        if (comment.authorUid == currentUserUid)
          ThreeDots(
            onEditTap: () {
              GoRouter.of(context).pop();
               context.read<PostDetailsViewController>().onEditCommentTap(comment.id);
            },
            onDeleteTap: () {
              // TODO : delete comment
            },
          ),
      ],
    );
  }

  String _getAuthorName(
    BuildContext context, {
    required String currentUserUid,
  }) {
    if (comment.authorUid == currentUserUid) return 'You';
    return comment.authorUsername;
  }
}
