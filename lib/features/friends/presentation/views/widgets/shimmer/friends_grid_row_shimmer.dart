import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/shimmer/friends_grid_item_shimmer.dart';

class FriendsGridRowShimmer extends StatelessWidget {
  const FriendsGridRowShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12.w,
      children: const [
        Expanded(child: FriendsGridItemShimmer()),
        Expanded(child: FriendsGridItemShimmer()),
      ],
    );
  }
}
