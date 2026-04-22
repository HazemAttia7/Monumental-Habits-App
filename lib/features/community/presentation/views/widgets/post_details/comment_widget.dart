import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/helper/service_locator.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pixel_true_app/features/community/data/models/comment_model.dart';
import 'package:pixel_true_app/features/community/data/models/reply_model.dart';
import 'package:pixel_true_app/features/community/data/repos/replies_repo.dart';
import 'package:pixel_true_app/features/community/presentation/managers/replies_cubit/replies_cubit.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/comment_when_collapsed.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/replies_tree.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/replies_teaser.dart';

class CommentWidget extends StatefulWidget {
  final Comment comment;

  const CommentWidget({super.key, required this.comment});

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  bool _showReplies = false;
  String? _replyingToUsername;

  /// Fake reply used to inject input inside tree
  Reply _buildFakeReply() {
    return Reply(
      id: '__typing__',
      authorUsername: context.read<AuthCubit>().currentUser!.name,
      text: '',
      createdAt: DateTime.now(),
      postId: widget.comment.postId,
      commentId: widget.comment.id,
      authorUid: '',
      likedByUids: [],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          RepliesCubit(sl<RepliesRepo>())
            ..watchReplies(widget.comment.postId, widget.comment.id),
      child: BlocBuilder<RepliesCubit, RepliesState>(
        builder: (context, state) {
          if (state is RepliesLoading) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          if (state is RepliesError) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(state.errMessage),
            );
          }
          if (state is RepliesSuccess) {
            final replies = state.replies;

            /// Inject fake reply if typing
            final displayReplies = [
              ...replies,
              if (_replyingToUsername != null) _buildFakeReply(),
            ];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🔵 COMMENT (when collapsed)
                if (!_showReplies)
                  CommentWhenCollapsed(
                    comment: widget.comment,
                    showReplies: _showReplies,
                    onReplyTap: () => setState(() {
                      _replyingToUsername = widget.comment.authorUsername;
                      _showReplies = true;
                    }),
                  ),

                /// 🔽 VIEW REPLIES
                if (!_showReplies && replies.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(left: 52.w, top: 3.h),
                    child: RepliesTeaser(
                      onViewRepliesTap: () {
                        setState(() => _showReplies = true);
                      }, 
                    ),
                  ),

                /// 🔽 TREE (expanded)
                if (_showReplies &&
                    (replies.isNotEmpty || _replyingToUsername != null))
                  RepliesTree(
                    comment: widget.comment,
                    displayReplies: displayReplies,
                    replyingToUsername: _replyingToUsername,
                    onReplyToReplyTap: (Reply reply) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        setState(() {
                          _replyingToUsername = reply.authorUsername;
                        });
                      });
                    },
                    onHideRepliesTap: () {
                      setState(() {
                        _showReplies = false;
                        _replyingToUsername = null;
                      });
                    },
                    onDone: () => setState(() => _replyingToUsername = null),
                    onReplyTap: () => setState(() {
                      _replyingToUsername = widget.comment.authorUsername;
                      _showReplies = true;
                    }),
                  ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
