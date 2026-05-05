import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/helper/service_locator.dart';
import 'package:pixel_true_app/core/widgets/custom_button.dart';
import 'package:pixel_true_app/core/widgets/custom_text_form_field.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pixel_true_app/features/community/data/models/post_model.dart';
import 'package:pixel_true_app/features/community/data/repos/posts_repo.dart';
import 'package:pixel_true_app/features/community/presentation/managers/posts_cubit/posts_cubit.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/add_post_card_header.dart';

class AddPostCard extends StatefulWidget {
  const AddPostCard({super.key});

  @override
  State<AddPostCard> createState() => _AddPostCardState();
}

class _AddPostCardState extends State<AddPostCard> {
  bool _isLoading = false;
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _submitPost() async {
    if (!_formKey.currentState!.validate()) {
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });
      return;
    }
    final content = _controller.text.trim();
    if (content.isEmpty) return;

    setState(() => _isLoading = true);
    final currentUser = BlocProvider.of<AuthCubit>(context).currentUser!;
    final id = sl<PostsRepo>().generatePostId();

    bool isAdded = await context.read<PostsCubit>().createPost(
      Post(
        id: id,
        authorUid: currentUser.uid,
        authorUsername: currentUser.name,
        content: content,
        createdAt: DateTime.now(),
        likedByUids: [],
        commentsCount: 0,
      ),
    );
    if (!mounted || !isAdded) return;
    setState(() => _isLoading = false);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: _autovalidateMode,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: Colors.white,
        ),
        child: Column(
          children: [
            const AddPostCardHeader(),
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
                if (data?.isEmpty ?? true) return 'Post cannot be empty';
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
                  text: _isLoading ? "Posting..." : "Post",
                  onTap: _submitPost,
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
