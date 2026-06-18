import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/core/enums/friends_enums.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/core/widgets/default_view_header.dart';
import 'package:pixel_true_app/features/friends/presentation/managers/friends_cubit/friends_cubit.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/friend_reqs_list.dart';

class AllRequestsViewBody extends StatelessWidget {
  const AllRequestsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final extra = GoRouterState.of(context).extra as Map<String, dynamic>?;

    final requestType =
        extra?['requestType'] as enRequestType? ?? enRequestType.received;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kPagePadding.w),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 18.h),
                child: DefaultViewHeader(
                  title: "All ${_getRequestType(requestType)} Requests",
                ),
              ),
            ),
            SliverToBoxAdapter(child: Gap(24.h)),
            BlocBuilder<FriendsCubit, FriendsState>(
              buildWhen: (p, c) => c is FriendsViewLoaded,
              builder: (context, state) {
                if (state is FriendsViewLoaded) {
                  return FriendReqsList(
                    friendReqs: requestType == enRequestType.received
                        ? state.receivedRequests
                        : state.sentRequests,
                    type: requestType,
                    viewAll: true,
                  );
                }
                return const SliverToBoxAdapter(child: SizedBox.shrink());
              },
            ),
          ],
        ),
      ),
    );
  }

  String _getRequestType(enRequestType requestType) {
    switch (requestType) {
      case enRequestType.received:
        return "Received";
      case enRequestType.sent:
        return "Sent";
    }
  }
}
