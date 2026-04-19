import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/community/data/models/comment_model.dart';
import 'package:pixel_true_app/features/community/presentation/managers/replies_cubit/replies_cubit.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/new_replies_banner.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/reply_widget.dart';

class RepliesList extends StatelessWidget {
  final void Function(String username) onReplyTap;
  final void Function() onDone;
  final Comment comment;
  final String? replyingToUsername;

  const RepliesList({
    super.key,
    required this.onReplyTap,
    required this.onDone,
    required this.comment,
    required this.replyingToUsername,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RepliesCubit, RepliesState>(
      builder: (context, state) => switch (state) {
        RepliesInitial() => const SizedBox.shrink(),
        // TODO : add shimmer effect
        RepliesLoading() => const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Center(child: CircularProgressIndicator()),
        ),
        RepliesError(:final errMessage) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(errMessage, style: AppStyles.textStyle14),
        ),
        RepliesSuccess(:final replies, :final hasNewReplies) => Column(
          children: [
            if (hasNewReplies) const NewRepliesBanner(),
            ...replies.map(
              (reply) => Padding(
                padding: EdgeInsets.only(top: 12.h),
                child: ReplyWidget(
                  reply: reply,
                  onReplyTap: () => onReplyTap(reply.authorUsername),
                  onDone: onDone,
                  comment: comment,
                  replyingToUsername: replyingToUsername,
                ),
              ),
            ),
          ],
        ),
      },
    );
  }
}
