import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/friend_requests_section.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/friends_view_header.dart';

class FriendsViewBody extends StatelessWidget {
  const FriendsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kPagePadding.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(12.h),
            const FriendsViewHeader(),
            Gap(24.h),
            const FriendRequestsSection(),
          ],
        ),
      ),
    );
  }
}
