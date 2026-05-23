import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/features/friends/data/models/friend_model.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/best_streak_widget.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/friend_info_column.dart';

class FriendGridItem extends StatelessWidget {
  final Friend friend;
  const FriendGridItem({super.key, required this.friend});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(child: FriendInfoColumn(username: friend.username)),
          Gap(4.w),
          BestStreakWidget(bestStreak: friend.bestStreak),
        ],
      ),
    );
  }
}
