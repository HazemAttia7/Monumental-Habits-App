import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/best_streak_widget.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/friend_info_column.dart';
import 'package:shimmer/shimmer.dart';

class FriendsGridItemShimmer extends StatelessWidget {
  const FriendsGridItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Row(
          spacing: 4.w,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: const [
            Flexible(child: FriendInfoColumn(username: "user")),
            BestStreakWidget(bestStreak: 100),
          ],
        ),
      ),
    );
  }
}
