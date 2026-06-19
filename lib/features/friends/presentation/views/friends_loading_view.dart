import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/friends_view_header.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/shimmer/friend_requests_section_shimmer.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/shimmer/your_friends_section_shimmer.dart';

class FriendsLoadingView extends StatelessWidget {
  const FriendsLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kPagePadding.w),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 18.h, bottom: 24.h),
                child: const FriendsViewHeader(),
              ),
              const FriendRequestsSectionShimmer(
                requestType: "received",
                listCount: 3,
              ),
              Gap(18.h),
              const FriendRequestsSectionShimmer(
                requestType: "sent",
                listCount: 1,
              ),
              Gap(18.h),
              const YourFriendsSectionShimmer(),
            ],
          ),
        ),
      ),
    );
  }
}
