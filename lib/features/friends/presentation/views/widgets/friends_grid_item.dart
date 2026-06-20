import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_router.dart';
import 'package:pixel_true_app/features/friends/data/models/friend_model.dart';
import 'package:pixel_true_app/features/friends/presentation/managers/friends_cubit/friends_cubit.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/best_streak_widget.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/friend_info_column.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/delete_dialog.dart';
import 'package:provider/provider.dart';

class FriendGridItem extends StatelessWidget {
  final Friend friend;
  const FriendGridItem({super.key, required this.friend});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        splashColor: AppColors.primaryColor.withValues(alpha: .1),
        highlightColor: AppColors.primaryColor.withValues(alpha: .1),
        onTap: () => GoRouter.of(context).push(
          AppRouter.kUserProfile,
          extra: {"uid": friend.uid, "cubit": context.read<FriendsCubit>()},
        ),
        onLongPress: () => showDialog(
          context: context,
          builder: (dialogContext) => DeleteDialog(
            itemLabel: "'${friend.username}'",
            onDelete: () {
              context.read<FriendsCubit>().removeFriend(friendId: friend.uid);
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
        child: Container(
          padding: EdgeInsets.all(12.sp),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(child: FriendInfoColumn(username: friend.username)),
              Gap(4.w),
              BestStreakWidget(bestStreak: friend.bestStreak),
            ],
          ),
        ),
      ),
    );
  }
}
