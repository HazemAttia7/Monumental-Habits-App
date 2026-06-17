import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/features/friends/data/models/friend_model.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/best_streak_widget.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/friend_req_info_row.dart';

class FriendCard extends StatelessWidget {
  final Friend friend;
  const FriendCard({super.key, required this.friend});

  @override
  Widget build(BuildContext context) {
    // TODO : on long press show rempve friend dialog
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        onTap: () {
          // TODO : navigate to profile
        },
        borderRadius: BorderRadius.circular(16.r),
        splashColor: AppColors.primaryColor.withValues(alpha: .1),
        highlightColor: AppColors.primaryColor.withValues(alpha: .1),
        child: Container(
          padding: EdgeInsets.all(12.sp),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FriendReqInfoRow(username: friend.username),
              BestStreakWidget(bestStreak: friend.bestStreak),
            ],
          ),
        ),
      ),
    );
  }
}
