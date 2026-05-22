import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/friends/data/models/friend_request_model.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/friend_req_card.dart';

// TODO : make only 3 requests shown
class FriendReqsList extends StatelessWidget {
  final List<FriendRequest> friendReqs;
  const FriendReqsList({super.key, required this.friendReqs});

  @override
  Widget build(BuildContext context) {
    return friendReqs.isEmpty
        ? SliverToBoxAdapter(
            child: SizedBox(
              child: Center(
                child: Text(
                  "No friend requests yet !",
                  textAlign: TextAlign.center,
                  style: AppStyles.textStyle17,
                ),
              ),
            ),
          )
        : SliverList.separated(
            itemBuilder: (_, index) =>
                FriendReqCard(friendReq: friendReqs[index]),
            separatorBuilder: (_, __) => Gap(16.h),
            itemCount: friendReqs.length,
          );
  }
}
