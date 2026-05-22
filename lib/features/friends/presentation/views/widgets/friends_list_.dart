import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/friend_card.dart';

class FriendsList extends StatelessWidget {
  const FriendsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemBuilder: (_, __) => const FriendCard(),
      separatorBuilder: (_, __) => Gap(16.h),
      itemCount: 2,
    );
  }
}
