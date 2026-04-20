import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/widgets/custom_button.dart';
import 'package:pixel_true_app/core/widgets/custom_clickable_text.dart';
import 'package:pixel_true_app/core/widgets/custom_text_form_field.dart';
import 'package:pixel_true_app/features/community/data/models/comment_model.dart';
import 'package:pixel_true_app/features/community/presentation/managers/mention_text_editing_controller.dart';

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
  late final MentionTextEditingController _controller;
  late final String _mention;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _mention = '@${widget.replyingToUsername} ';
    _controller = MentionTextEditingController(
      mention: '@${widget.replyingToUsername}',
    );

    _controller.addListener(() {
      // prevent deleting the mention
      if (!_controller.text.startsWith(_mention)) {
        _controller.value = _controller.value.copyWith(
          text: _mention,
          selection: TextSelection.collapsed(offset: _mention.length),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() => _isLoading = true);

    // TODO : add reply
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
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            top: 8.h,
            left: 8.w,
            right: 8.w,
            bottom: 10.h,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFormField(
                fillColor: Colors.white,
                isDense: true,
                autofocus: true,
                controller: _controller,
                hintText: "reply to @${widget.replyingToUsername}",
                textColor: Colors.black,
                maxLines: null,
                contentPadding: EdgeInsets.zero,
                fontSize: 13.sp,
                fontWeight: FontWeight.normal,
              ),
            ],
          ),
        ),
        Gap(8.h),
        Row(
          spacing: 12.w,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomButton(
              height: 30.h,
              width: 80.w,
              fontSize: 12.sp,
              text: _isLoading ? "Comment..." : "Comment",
              onTap: _submit,
            ),
            CustomClickableText(
              fontSize: 12.sp,
              text: "Cancel",
              textColor: AppColors.secondaryColor,
              onTap: widget.onDone,
            ),
          ],
        ),
      ],
    );
  }
}
