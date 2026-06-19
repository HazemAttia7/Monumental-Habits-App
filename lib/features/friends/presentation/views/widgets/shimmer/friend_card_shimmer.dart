import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/best_streak_widget.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/user_info_row.dart';
import 'package:shimmer/shimmer.dart';

class FriendCardShimmer extends StatelessWidget {
  const FriendCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: const Row(
          children: [
            Expanded(child: UserInfoRow(username: "user")),
            BestStreakWidget(bestStreak: 100),
          ],
        ),
      ),
    );
  }
}
