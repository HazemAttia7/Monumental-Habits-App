import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/friend_req_card.dart';

class FriendReqsList extends StatelessWidget {
  const FriendReqsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemBuilder: (_, __) => const FriendReqCard(),
      separatorBuilder: (_, __) => Gap(16.h),
      itemCount: 2,
    );
  }
}
