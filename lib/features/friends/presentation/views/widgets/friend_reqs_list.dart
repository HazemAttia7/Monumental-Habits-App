import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/enums/friends_enums.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/friends/data/models/friend_request_model.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/friend_req_card.dart';

class FriendReqsList extends StatelessWidget {
  final List<FriendRequest> friendReqs;
  final enRequestType type;
  const FriendReqsList({
    super.key,
    required this.friendReqs,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final bool isLong = friendReqs.length > 2;
    return friendReqs.isEmpty
        ? SliverToBoxAdapter(
            child: SizedBox(
              child: Center(
                child: Text(
                  "No ${type.name} friend requests yet !",
                  textAlign: TextAlign.center,
                  style: AppStyles.textStyle17,
                ),
              ),
            ),
          )
        : SliverList.separated(
            itemBuilder: (_, index) =>
                FriendReqCard(friendReq: friendReqs[index], type: type),
            separatorBuilder: (_, __) => Gap(16.h),
            itemCount: isLong ? 2 : friendReqs.length,
          );
  }
}
