import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/shimmer/friend_card_shimmer.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/shimmer/friends_grid_row_shimmer.dart';

class FriendsListShimmer extends StatelessWidget {
  const FriendsListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (_, index) =>
          index > 1 ? const FriendsGridRowShimmer() : const FriendCardShimmer(),
      separatorBuilder: (_, __) => Gap(16.h),
      itemCount: 3,
    );
  }
}
