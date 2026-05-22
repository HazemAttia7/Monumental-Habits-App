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
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/shimmer/post_section_shimmer.dart';
import 'package:provider/provider.dart';

class PostSection extends StatefulWidget {
  const PostSection({super.key});

  @override
  State<PostSection> createState() => _PostSectionState();
}

class _PostSectionState extends State<PostSection> {
  EditContentController? _editController;
  Post? post;

  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_initialized) return;
    _initialized = true;

    _loadPost();
  }

  Future<void> _loadPost() async {
    final state = GoRouterState.of(context);
    final extra = state.extra as Map<String, dynamic>?;

    if (extra != null && extra['post'] != null) {
      post = extra['post'] as Post;
    } else {
      final postId = state.pathParameters['postId']!;

      post = await context.read<PostsCubit>().getPostById(postId);
    }

    _editController = EditContentController(post?.content ?? '');

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _editController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (post == null || _editController == null) {
      return const PostSectionShimmer();
    }

    final currentPost = post!;
    final editController = _editController!;

    final controller = context.watch<CommunityViewController>();

    final isEditing =
        controller.isEditPostMode && controller.postIdToEdit == currentPost.id;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isEditing) {
        editController.setText(currentPost.content);
      }
    });

    return ChangeNotifierProvider.value(
      value: editController,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(16.h),
            PostSectionHeader(post: currentPost),
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
                                    (p) => p.id == currentPost.id,
                                    orElse: () => currentPost,
                                  )
                                  .content
                            : currentPost.content;

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
                  onConfirm: () => editController.submit((newContent) async {
                    if (newContent == currentPost.content) return;

                    await context.read<PostsCubit>().editPost(
                      currentPost.id,
                      newContent,
                    );

                    controller.onDoneEditPost();
                  }),
                  isLoading: editController.isLoading,
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
                          (p) => p.id == currentPost.id,
                          orElse: () => currentPost,
                        )
                      : currentPost;

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

            ActionsRow(post: currentPost),
          ],
        ),
      ),
    );
  }
}
