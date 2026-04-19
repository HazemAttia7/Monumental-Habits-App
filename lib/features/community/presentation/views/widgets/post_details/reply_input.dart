import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/community/data/models/comment_model.dart';

class ReplyInput extends StatefulWidget {
  final String replyingToUsername;
  final Comment comment;
  final VoidCallback onDone;

  const ReplyInput({
    super.key,
    required this.replyingToUsername,
    required this.comment,
    required this.onDone,
  });

  @override
  State<ReplyInput> createState() => _ReplyInputState();
}

class _ReplyInputState extends State<ReplyInput> {
  final _controller = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() => _isLoading = true);

    // // get current user from your auth cubit/provider
    // final currentUser = context.read<AuthCubit>().currentUser;

    // await sl<CommentsRepo>().postReply(
    //   postId: widget.comment.postId,
    //   commentId: widget.comment.id,
    //   authorUid: currentUser.uid,
    //   authorUsername: currentUser.username,
    //   replyToUsername: widget.replyingToUsername,
    //   text: text,
    // );

    setState(() => _isLoading = false);
    widget.onDone();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              autofocus: true,
              decoration: InputDecoration(
                hintText: '@${widget.replyingToUsername}',
                isDense: true,
              ),
            ),
          ),
          Gap(8.w),
          _isLoading
              ? const CircularProgressIndicator()
              : GestureDetector(
                  onTap: _submit,
                  child: Text('Send', style: AppStyles.textStyle14),
                ),
          Gap(8.w),
          GestureDetector(
            onTap: widget.onDone,
            child: Text('Cancel', style: AppStyles.textStyle14),
          ),
        ],
      ),
    );
  }
}
