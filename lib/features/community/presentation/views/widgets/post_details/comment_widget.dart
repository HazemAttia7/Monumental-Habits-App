import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/helper/service_locator.dart';
import 'package:pixel_true_app/core/widgets/profile_placeholder.dart';
import 'package:pixel_true_app/features/community/data/models/comment_model.dart';
import 'package:pixel_true_app/features/community/data/repos/replies_repo.dart';
import 'package:pixel_true_app/features/community/presentation/managers/replies_cubit/replies_cubit.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/comment_card.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/replies_section.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/replies_teaser.dart';

// TODO : study the new changes, yeild in stream and cubits
class CommentWidget extends StatefulWidget {
  final Comment comment;
  const CommentWidget({super.key, required this.comment});

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  bool _showReplies = false;
  String? _replyingToUsername;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          RepliesCubit(sl<RepliesRepo>())
            ..watchReplies(widget.comment.postId, widget.comment.id),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfilePlaceholder(
            userName: widget.comment.authorUsername,
            width: 40.w,
            height: 40.h,
            padding: EdgeInsets.all(2.sp),
          ),
          Gap(12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommentCard(
                comment: widget.comment,
                showReplies: _showReplies,
                onReplyTap: () => setState(
                  () => _replyingToUsername = widget.comment.authorUsername,
                ),
                onViewRepliesTap: () => setState(() {
                  _showReplies = false;
                }),
              ),
              if (!_showReplies)
                RepliesTeaser(
                  onViewRepliesTap: () => setState(() {
                    _showReplies = true;
                  }),
                )
              else
                RepliesSection(
                  comment: widget.comment,
                  replyingToUsername: _replyingToUsername,
                  onReplyTap: (username) =>
                      setState(() => _replyingToUsername = username),
                  onDone: () => setState(() => _replyingToUsername = null),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
