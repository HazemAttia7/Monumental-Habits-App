import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pixel_true_app/features/community/data/models/reply_model.dart';
import 'package:pixel_true_app/features/community/presentation/managers/post_details_view_controller.dart';
import 'package:pixel_true_app/features/community/presentation/managers/replies_cubit/replies_cubit.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/three_dots.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/delete_dialog.dart';
import 'package:provider/provider.dart';

class ReplyCardHeader extends StatelessWidget {
  final Reply reply;
  const ReplyCardHeader({super.key, required this.reply});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          reply.authorUsername,
          style: AppStyles.textStyle14.copyWith(fontWeight: FontWeight.bold),
        ),
        if (reply.authorUid == context.read<AuthCubit>().currentUser!.uid)
          ThreeDots(
            onEditTap: () {
              GoRouter.of(context).pop();
              context.read<PostDetailsViewController>().onEditReplyTap(
                reply.id,
              );
            },
            onDeleteTap: () {
              GoRouter.of(context).pop();
              showDialog(
                context: context,
                builder: (dialogContext) => DeleteDialog(
                  itemLabel: "this reply",
                  onDelete: () {
                    context.read<RepliesCubit>().deleteReply(
                      reply.postId,
                      reply.commentId,
                      reply.id,
                    );
                    GoRouter.of(context).pop();
                  },
                  headerIcon: Icons.delete,
                  collectionLabel: 'replies',
                  itemType: 'reply',
                ),
              );
            },
          ),
      ],
    );
  }
}
