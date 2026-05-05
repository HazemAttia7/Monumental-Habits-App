import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_router.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/community/data/models/post_model.dart';
import 'package:pixel_true_app/features/community/presentation/managers/community_view_controller.dart';
import 'package:pixel_true_app/features/community/presentation/managers/edit_content_controller.dart';
import 'package:pixel_true_app/features/community/presentation/managers/posts_cubit/posts_cubit.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_card_header.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/expandable_content.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/edit_actions_row.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/editable_content.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_interactions.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final Post post;
  const PostCard({super.key, required this.post});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late final EditContentController _editController;

  @override
  void initState() {
    super.initState();
    _editController = EditContentController(widget.post.content);
  }

  @override
  void didUpdateWidget(PostCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.post.content != widget.post.content) {
      _editController.textController.text = widget.post.content;
    }
  }

  @override
  void dispose() {
    _editController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CommunityViewController>();

    if (widget.post.content != _editController.textController.text) {
      _editController.textController.text = widget.post.content;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.isEditPostMode &&
          controller.postIdToEdit == widget.post.id) {
        _editController.setText(widget.post.content);
      }
    });

    final isEditing =
        controller.isEditPostMode && controller.postIdToEdit == widget.post.id;

    return ChangeNotifierProvider.value(
      value: _editController,
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: isEditing
              ? null // disable navigation while editing
              : () => GoRouter.of(context).push(
                  AppRouter.kPostDetailsView,
                  extra: {
                    "post": widget.post,
                    'cubit': context.read<PostsCubit>(),
                  },
                ),
          splashColor: AppColors.secondaryColor.withValues(alpha: .1),
          highlightColor: AppColors.secondaryColor.withValues(alpha: .1),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PostCardHeader(
                  post: widget.post,
                  postedSince: _getPostedSinceDuration(),
                ),
                isEditing
                    ? const EditableContent()
                    : ExpandableContent(
                        content: widget.post.content,
                        style: AppStyles.textStyle14.copyWith(
                          color: Colors.black,
                        ),
                      ),
                if (isEditing)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: EditActionsRow(
                      onConfirm: () =>
                          _editController.submit((newContent) async {
                            if (newContent == widget.post.content) return;
                            await context.read<PostsCubit>().editPost(
                              widget.post.id,
                              newContent,
                            );
                            controller.onDoneEditPost();
                          }),
                      isLoading: _editController.isLoading,
                    ),
                  ),
                PostInteractions(post: widget.post),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Duration _getPostedSinceDuration() {
    final now = DateTime.now();
    final difference = now.difference(widget.post.createdAt);
    if (difference.inDays > 0) return Duration(days: difference.inDays);
    if (difference.inHours > 0) return Duration(hours: difference.inHours);
    if (difference.inMinutes > 0) {
      return Duration(minutes: difference.inMinutes);
    }
    return Duration(seconds: difference.inSeconds);
  }
}
