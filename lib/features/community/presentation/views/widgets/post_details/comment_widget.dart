import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/helper/service_locator.dart';
import 'package:pixel_true_app/core/widgets/profile_placeholder.dart';
import 'package:pixel_true_app/features/community/data/models/comment_model.dart';
import 'package:pixel_true_app/features/community/data/repos/replies_repo.dart';
import 'package:pixel_true_app/features/community/presentation/managers/replies_cubit/replies_cubit.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/comment_thread.dart';

// TODO : study the new changes, yeild in stream and cubits
class CommentWidget extends StatelessWidget {
  final Comment comment;
  const CommentWidget({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          RepliesCubit(sl<RepliesRepo>())
            ..watchReplies(comment.postId, comment.id),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfilePlaceholder(
            userName: comment.authorUsername,
            width: 40.w,
            height: 40.h,
            padding: EdgeInsets.all(2.sp),
          ),
          Gap(12.w),
          Expanded(child: CommentThread(comment: comment)),
        ],
      ),
    );
  }
}
