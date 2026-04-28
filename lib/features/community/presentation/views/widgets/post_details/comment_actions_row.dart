import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/custom_clickable_text.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pixel_true_app/features/community/data/models/comment_model.dart';
import 'package:pixel_true_app/features/community/helper/get_like_text.dart';
import 'package:pixel_true_app/features/community/helper/get_time_ago.dart';
import 'package:pixel_true_app/features/community/presentation/managers/comments_cubit/comments_cubit.dart';

class CommentActionsRow extends StatefulWidget {
  final VoidCallback onReplyTap, onHideRepliesTap;
  final bool showReplies;
  final Comment comment;
  const CommentActionsRow({
    super.key,
    required this.onReplyTap,
    required this.onHideRepliesTap,
    this.showReplies = false,
    required this.comment,
  });

  @override
  State<CommentActionsRow> createState() => _CommentActionsRowState();
}

class _CommentActionsRowState extends State<CommentActionsRow> {
  late bool _isLiked;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.comment.isLikedBy(
      BlocProvider.of<AuthCubit>(context).currentUser!.uid,
    );
  }

  @override
  void didUpdateWidget(covariant CommentActionsRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    _isLiked = widget.comment.isLikedBy(
      BlocProvider.of<AuthCubit>(context).currentUser!.uid,
    );
  }

  @override
  Widget build(BuildContext context) {
    final String currentUserUid = BlocProvider.of<AuthCubit>(
      context,
    ).currentUser!.uid;
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 12.w,
      children: [
        CustomClickableText(
          text: "REPLY",
          onTap: widget.onReplyTap,
          textColor: Color.lerp(AppColors.primaryColor, Colors.black, .35),
          fontSize: 12.sp,
        ),
        // TODO : change text color when liked
        CustomClickableText(
          text: getLikeText<Comment>(currentUserUid, widget.comment),
          onTap: () async {
            await BlocProvider.of<CommentsCubit>(
              context,
            ).toggleCommentLike(widget.comment, currentUserUid);
            setState(() {
              _isLiked = !_isLiked;
            });
          },
          textColor: AppColors.secondaryColor,
          fontSize: 12.sp,
        ),
        Text(
          getTimeAgo(DateTime.now().difference(widget.comment.createdAt)),
          style: AppStyles.textStyle12,
        ),
        if (widget.showReplies)
          CustomClickableText(
            onTap: widget.onHideRepliesTap,
            text: "Hide Replies",
            textColor: AppColors.secondaryColor,
            fontSize: 12.sp,
            textDecoration: TextDecoration.underline,
          ),
      ],
    );
  }
}
