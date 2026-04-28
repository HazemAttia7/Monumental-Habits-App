import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/custom_clickable_text.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pixel_true_app/features/community/data/models/reply_model.dart';
import 'package:pixel_true_app/features/community/helper/get_like_text.dart';
import 'package:pixel_true_app/features/community/helper/get_time_ago.dart';
import 'package:pixel_true_app/features/community/presentation/managers/replies_cubit/replies_cubit.dart';

class ReplyActionsRow extends StatefulWidget {
  final Function(Reply) onReplyTap;
  final bool showReplies;
  final Reply reply;
  const ReplyActionsRow({
    super.key,
    required this.onReplyTap,
    this.showReplies = false,
    required this.reply,
  });

  @override
  State<ReplyActionsRow> createState() => _ReplyActionsRowState();
}

class _ReplyActionsRowState extends State<ReplyActionsRow> {
  late bool _isLiked;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.reply.isLikedBy(
      BlocProvider.of<AuthCubit>(context).currentUser!.uid,
    );
  }

  @override
  void didUpdateWidget(covariant ReplyActionsRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    _isLiked = widget.reply.isLikedBy(
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
          onTap: () => widget.onReplyTap(widget.reply),
          textColor: Color.lerp(AppColors.primaryColor, Colors.black, .35),
          fontSize: 12.sp,
        ),
        // TODO : change text color when liked
        CustomClickableText(
          text: getLikeText<Reply>(currentUserUid, widget.reply),
          onTap: () async {
            await BlocProvider.of<RepliesCubit>(
              context,
            ).toggleReplyLike(widget.reply, currentUserUid);
            setState(() {
              _isLiked = !_isLiked;
            });
          },
          textColor: AppColors.secondaryColor,
          fontSize: 12.sp,
        ),
        Text(
          getTimeAgo(DateTime.now().difference(widget.reply.createdAt)),
          style: AppStyles.textStyle12,
        ),
      ],
    );
  }
}
