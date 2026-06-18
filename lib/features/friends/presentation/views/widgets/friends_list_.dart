import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/friends/data/models/friend_model.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/friend_card.dart';

class FriendsList extends StatelessWidget {
  final List<Friend> friends;
  final bool viewAll;
  const FriendsList({super.key, required this.friends, this.viewAll = false});

  @override
  Widget build(BuildContext context) {
    final isLong = friends.length >= 4;
    return friends.isEmpty
        ? SliverFillRemaining(
            child: Center(
              child: Text(
                "No friends yet !\nAdd one to get started.",
                textAlign: TextAlign.center,
                style: AppStyles.textStyle17,
              ),
            ),
          )
        : SliverList.separated(
            itemBuilder: (_, index) => FriendCard(friend: friends[index]),
            separatorBuilder: (_, __) => Gap(16.h),
            itemCount: (!viewAll && isLong) ? 2 : friends.length,
          );
  }
}
