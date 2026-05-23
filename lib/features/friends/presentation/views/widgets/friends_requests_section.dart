import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/features/friends/data/models/friend_request_model.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/friend_reqs_list.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/more_requests_badge.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/section_header.dart';
import 'package:sliver_tools/sliver_tools.dart';

class FriendRequestsSection extends StatelessWidget {
  const FriendRequestsSection({super.key, required this.requests});

  final List<FriendRequest> requests;

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      children: [
        SliverToBoxAdapter(
          child: SectionHeader(
            text: "FRIEND REQUESTS (${requests.length})",
            viewAll: () {
              // TODO : implement view all friend requests
            },
          ),
        ),
        SliverToBoxAdapter(child: Gap(16.h)),
        FriendReqsList(friendReqs: requests),
        SliverToBoxAdapter(child: Gap(18.h)),
        if (requests.length > 2)
          SliverToBoxAdapter(
            child: MoreRequestsBadge(requestsLength: requests.length),
          ),
      ],
    );
  }
}
