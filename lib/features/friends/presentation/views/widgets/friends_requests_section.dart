import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/core/enums/friends_enums.dart';
import 'package:pixel_true_app/core/utils/app_router.dart';
import 'package:pixel_true_app/features/friends/data/models/friend_request_model.dart';
import 'package:pixel_true_app/features/friends/presentation/managers/friends_cubit/friends_cubit.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/friend_reqs_list.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/more_requests_badge.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/section_header.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';

class FriendRequestsSection extends StatelessWidget {
  final enRequestType requestType;
  final List<FriendRequest> requests;
  const FriendRequestsSection({
    super.key,
    required this.requests,
    required this.requestType,
  });

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      children: [
        SliverToBoxAdapter(
          child: SectionHeader(
            text:
                "${requestType.name.toUpperCase()} REQUESTS (${requests.length})",
            viewAll: () => GoRouter.of(context).push(
              AppRouter.kAllRequests,
              extra: {
                "requests": requests,
                "requestType": requestType,
                "cubit": context.read<FriendsCubit>(),
              },
            ),
          ),
        ),
        SliverToBoxAdapter(child: Gap(16.h)),
        FriendReqsList(friendReqs: requests, type: requestType),
        SliverToBoxAdapter(child: Gap(18.h)),
        if (requests.length > 2)
          SliverToBoxAdapter(
            child: MoreRequestsBadge(requestsLength: requests.length),
          ),
      ],
    );
  }
}
