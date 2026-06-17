import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/enums/friends_enums.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/features/friends/data/models/friend_model.dart';
import 'package:pixel_true_app/features/friends/data/models/friend_request_model.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/friends_requests_section.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/friends_view_header.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/your_friends_section.dart';

class FriendsLoadedView extends StatelessWidget {
  final List<Friend> friends;
  final List<FriendRequest> receivedRequests, sentRequests;
  const FriendsLoadedView({
    super.key,
    required this.friends,
    required this.receivedRequests,
    required this.sentRequests,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kPagePadding.w),
        child: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 18.h, bottom: 24.h),
                child: const FriendsViewHeader(),
              ),
            ),
            FriendRequestsSection(
              requests: receivedRequests,
              requestType: enRequestType.received,
            ),
            SliverToBoxAdapter(child: Gap(18.h)),
            FriendRequestsSection(
              requests: sentRequests,
              requestType: enRequestType.sent,
            ),
            SliverToBoxAdapter(child: Gap(18.h)),
            YourFriendsSection(friends: friends),
          ],
        ),
      ),
    );
  }
}
