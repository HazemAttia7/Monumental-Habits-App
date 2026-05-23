import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/features/friends/data/models/friend_model.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/friends_grid_item.dart';

class FriendsGridRow extends StatelessWidget {
  final Friend? friend1, friend2;
  const FriendsGridRow({super.key, this.friend1, this.friend2});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12.w,
      children: [
        if (friend1 != null) Expanded(child: FriendGridItem(friend: friend1!)),
        if (friend2 != null) Expanded(child: FriendGridItem(friend: friend2!)),
      ],
    );
  }
}
