import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/core/helper/service_locator.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_router.dart';
import 'package:pixel_true_app/core/widgets/profile_placeholder.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pixel_true_app/features/community/data/models/comment_model.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/comment_thread.dart';
import 'package:pixel_true_app/features/friends/data/repos/friends_repo.dart';
import 'package:pixel_true_app/features/friends/presentation/managers/friends_cubit/friends_cubit.dart';

class CommentWhenCollapsed extends StatelessWidget {
  final Comment comment;
  final bool showReplies;
  final VoidCallback onReplyTap;
  const CommentWhenCollapsed({
    super.key,
    required this.comment,
    required this.showReplies,
    required this.onReplyTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap:
              (context.read<AuthCubit>().currentUser!.uid == comment.authorUid)
              ? null
              : () => GoRouter.of(context).push(
                  AppRouter.kUserProfile,
                  extra: {
                    "uid": comment.authorUid,
                    "cubit": FriendsCubit(sl<FriendsRepo>())
                      ..getFriends()
                      ..getOutgoingFriendRequests()
                      ..getIncomingFriendRequests()
                      ..getPendingRequestIds(),
                  },
                ),
          child: ProfilePlaceholder(
            username: comment.authorUsername,
            padding: EdgeInsets.all(12.sp),
            backColor:
                comment.authorUid == context.read<AuthCubit>().currentUser!.uid
                ? AppColors.primaryColor
                : null,
          ),
        ),
        Gap(8.w),
        Expanded(
          child: CommentThread(
            comment: comment,
            showReplies: showReplies,
            onReplyTap: onReplyTap,
            onHideRepliesTap: () {},
          ),
        ),
      ],
    );
  }
}
