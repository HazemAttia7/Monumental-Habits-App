import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/core/helper/service_locator.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/core/widgets/custom_button.dart';
import 'package:pixel_true_app/core/widgets/custom_text_form_field.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pixel_true_app/features/community/data/models/comment_model.dart';
import 'package:pixel_true_app/features/community/data/models/post_model.dart';
import 'package:pixel_true_app/features/community/data/repos/comments_repo.dart';
import 'package:pixel_true_app/features/community/presentation/managers/comments_cubit/comments_cubit.dart';

class AddCommentCard extends StatefulWidget {
  const AddCommentCard({super.key});

  @override
  State<AddCommentCard> createState() => _AddCommentCardState();
}

class _AddCommentCardState extends State<AddCommentCard> {
  bool _isLoading = false;
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _submitComment() async {
    if (!_formKey.currentState!.validate()) {
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });
      return;
    }
    final content = _controller.text.trim();
    if (content.isEmpty) return;

    setState(() => _isLoading = true);
    final post = GoRouterState.of(context).extra as Post;
    final currentUser = BlocProvider.of<AuthCubit>(context).currentUser!;
    final id = sl<CommentsRepo>().generateCommentId(post.id);

    await context.read<CommentsCubit>().addComment(
      Comment(
        id: id,
        postId: post.id,
        authorUid: currentUser.uid,
        authorUsername: currentUser.name,
        content: content,
        createdAt: DateTime.now(),
        likedByUids: [],
      ),
    );

    if (!mounted) return;
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: _autovalidateMode,
      child: Container(
        constraints: BoxConstraints(maxWidth: 1.sw - 2 * kPagePadding.w - 52.w),
        padding: EdgeInsets.only(
          top: 6.h,
          bottom: 12.sp,
          left: 12.w,
          right: 12.w,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "You",
              style: AppStyles.textStyle14.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            CustomTextFormField(
              controller: _controller,
              fillColor: Colors.white,
              hintText: "What's on your mind?",
              textColor: Colors.black,
              maxLines: null,
              contentPadding: EdgeInsets.zero,
              fontSize: 13.sp,
              fontWeight: FontWeight.normal,
              validator: (data) {
                if (data?.isEmpty ?? true) return 'Comment cannot be empty';
                return null;
              },
            ),
            Gap(8.h),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: AbsorbPointer(
                absorbing: _isLoading,
                child: CustomButton(
                  height: 30.h,
                  text: _isLoading ? "Commenting..." : "Comment",
                  onTap: _submitComment,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
