import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/core/widgets/default_view_header.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/comments_section.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/comments_section_header.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/post_section.dart';

class PostDetailsViewBody extends StatefulWidget {
  final bool scrollToComments;
  const PostDetailsViewBody({super.key, required this.scrollToComments});

  @override
  State<PostDetailsViewBody> createState() => _PostDetailsViewBodyState();
}

class _PostDetailsViewBodyState extends State<PostDetailsViewBody> {
  late final ScrollController _scrollController;
  final _commentsKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    if (widget.scrollToComments) {
      WidgetsBinding.instance.addPostFrameCallback((_) => scrollToComments());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void scrollToComments() {
    final ctx = _commentsKey.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kPagePadding.w),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Gap(12.h),
                  const DefaultViewHeader(title: 'Post Details'),
                  Gap(18.h),
                  const PostSection(),
                  Gap(24.h),
                ],
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(bottom: 18.h),
              sliver: const SliverToBoxAdapter(child: CommentsSectionHeader()),
            ),
            CommentsSection(key: _commentsKey),
            SliverToBoxAdapter(child: Gap(40.h)),
          ],
        ),
      ),
    );
  }
}
