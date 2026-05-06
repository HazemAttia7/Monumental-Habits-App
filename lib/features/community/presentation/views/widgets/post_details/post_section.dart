import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/community/data/models/post_model.dart';
import 'package:pixel_true_app/features/community/presentation/managers/community_view_controller.dart';
import 'package:pixel_true_app/features/community/presentation/managers/edit_content_controller.dart';
import 'package:pixel_true_app/features/community/presentation/managers/posts_cubit/posts_cubit.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/expandable_content.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/actions_row.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/edit_actions_row.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/editable_content.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/interactions_info_row.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/post_section_header.dart';
import 'package:provider/provider.dart';

class PostSection extends StatefulWidget {
  const PostSection({super.key});

  @override
  State<PostSection> createState() => _PostSectionState();
}

class _PostSectionState extends State<PostSection> {
  late final EditContentController _editController;
  late Post post;
  bool _initialized = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;
    _initialized = true;

    final extra = GoRouterState.of(context).extra as Map<String, dynamic>;
    post = extra['post'] as Post;
    _editController = EditContentController(post.content);
  }

  @override
  void dispose() {
    _editController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CommunityViewController>();
    final isEditing =
        controller.isEditPostMode && controller.postIdToEdit == post.id;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isEditing) _editController.setText(post.content);
    });

    return ChangeNotifierProvider.value(
      value: _editController,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: PostSectionHeader(post: post),
            ),
            Gap(24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: isEditing
                  ? const EditableContent()
                  : BlocBuilder<PostsCubit, PostsState>(
                      builder: (context, state) {
                        final liveContent = state is PostSuccess
                            ? state.posts
                                  .firstWhere(
                                    (p) => p.id == post.id,
                                    orElse: () => post,
                                  )
                                  .content
                            : post.content;
                        return ExpandableContent(
                          content: liveContent,
                          style: AppStyles.textStyle14.copyWith(
                            color: Colors.black,
                          ),
                        );
                      },
                    ),
            ),
            if (isEditing) ...[
              Gap(8.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: EditActionsRow(
                  onConfirm: () => _editController.submit((newContent) async {
                    if (newContent == post.content) return;
                    await context.read<PostsCubit>().editPost(
                      post.id,
                      newContent,
                    );
                    controller.onDoneEditPost();
                  }),
                  isLoading: _editController.isLoading,
                ),
              ),
            ],
            Gap(18.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: BlocBuilder<PostsCubit, PostsState>(
                builder: (context, state) {
                  final livePost = state is PostSuccess
                      ? state.posts.firstWhere(
                          (p) => p.id == post.id,
                          orElse: () => post,
                        )
                      : post;
                  return InteractionsInfoRow(
                    likesCount: livePost.likesCount,
                    likedByUids: livePost.likedByUids,
                  );
                },
              ),
            ),
            Gap(8.h),
            Divider(
              color: AppColors.secondaryColor.withValues(alpha: .3),
              thickness: 1.sp,
              height: 1,
            ),
            ActionsRow(post: post),
          ],
        ),
      ),
    );
  }
}
