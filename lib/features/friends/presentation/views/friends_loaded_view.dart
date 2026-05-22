import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/core/widgets/custom_clickable_text.dart';
import 'package:pixel_true_app/features/friends/data/models/friend_model.dart';
import 'package:pixel_true_app/features/friends/data/models/friend_request_model.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/friend_reqs_list.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/friends_list_.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/friends_view_header.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/section_header.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/custom_search_field.dart';

class FriendsLoadedView extends StatelessWidget {
  final List<Friend> friends;
  final List<FriendRequest> requests;
  const FriendsLoadedView({
    super.key,
    required this.friends,
    required this.requests,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(18.h),
                  const FriendsViewHeader(),
                  Gap(12.h),
                  CustomSearchField(
                    onChanged: (value) {},
                    hintText: "Search for friends...",
                  ),
                  Gap(24.h),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: SectionHeader(
                text: "FRIEND REQUESTS (${requests.length})",
              ),
            ),
            SliverToBoxAdapter(child: Gap(16.h)),
            FriendReqsList(friendReqs: requests),
            SliverToBoxAdapter(child: Gap(36.h)),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SectionHeader(text: "YOUR FRIENDS"),
                  CustomClickableText(
                    text: "View All",
                    fontSize: 14.sp,
                    textColor: AppColors.secondaryColor,
                    onTap: () {
                      // TODO : implement view all friends
                    },
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(child: Gap(16.h)),
            FriendsList(friends: friends),
          ],
        ),
      ),
    );
  }
}
