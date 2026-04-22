import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/helper/service_locator.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/widgets/custom_button.dart';
import 'package:pixel_true_app/core/widgets/custom_clickable_text.dart';
import 'package:pixel_true_app/core/widgets/custom_text_form_field.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pixel_true_app/features/community/data/models/comment_model.dart';
import 'package:pixel_true_app/features/community/data/models/reply_model.dart';
import 'package:pixel_true_app/features/community/data/repos/replies_repo.dart';
import 'package:pixel_true_app/features/community/presentation/managers/mention_text_editing_controller.dart';
import 'package:pixel_true_app/features/community/presentation/managers/replies_cubit/replies_cubit.dart';

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
    final currentUser = BlocProvider.of<AuthCubit>(context).currentUser!;
    final id = sl<RepliesRepo>().generateReplyId(
      widget.comment.postId,
      widget.comment.id,
    );

    await context.read<RepliesCubit>().addReply(
      Reply(
        id: id,
        postId: widget.comment.postId,
        commentId: widget.comment.id,
        text: text.substring(_mention.length),
        authorUid: currentUser.uid,
        authorUsername: currentUser.name,
        replyToUsername: widget.replyingToUsername,
        createdAt: DateTime.now(),
        likedByUids: [],
      ),
    );

    if (!mounted) return;
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
            // TODO : add absorb pointer and change comment to reply
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
