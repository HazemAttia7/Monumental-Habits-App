import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_router.dart';
import 'package:pixel_true_app/features/friends/data/models/friend_model.dart';
import 'package:pixel_true_app/features/friends/presentation/managers/friends_cubit/friends_cubit.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/best_streak_widget.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/user_info_row.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/delete_dialog.dart';
import 'package:provider/provider.dart';

class FriendCard extends StatelessWidget {
  final Friend friend;
  const FriendCard({super.key, required this.friend});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        onTap: () => GoRouter.of(context).push(
          AppRouter.kUserProfile,
          extra: {"uid": friend.uid, "cubit": context.read<FriendsCubit>()},
        ),
        onLongPress: () => showDialog(
          context: context,
          builder: (dialogContext) => DeleteDialog(
            itemLabel: "'${friend.username}'",
            onDelete: () {
              // TODO : remove friend
              // context.read<FriendsCubit>().removeFriend(friend);
              GoRouter.of(context).pop();
            },
            headerIcon: FontAwesomeIcons.userXmark,
            headerIconSize: 22.sp,
            headerIconPadding: EdgeInsets.only(
              left: 12.w,
              right: 18.w,
              top: 12.h,
              bottom: 12.h,
            ),
            headerText: "Remove Friend",
            confirmButtonText: "Unfriend",
            collectionLabel: 'friends',
            itemType: 'friend',
          ),
        ),
        borderRadius: BorderRadius.circular(16.r),
        splashColor: AppColors.primaryColor.withValues(alpha: .1),
        highlightColor: AppColors.primaryColor.withValues(alpha: .1),
        child: Container(
          padding: EdgeInsets.all(12.sp),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r)),
          child: Row(
            children: [
              Expanded(child: UserInfoRow(username: friend.username)),
              BestStreakWidget(bestStreak: friend.bestStreak),
            ],
          ),
        ),
      ),
    );
  }
}
