import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/core/widgets/custom_clickable_text.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/friend_reqs_list.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/friends_list_.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/friends_view_header.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/section_header.dart';

class FriendsViewBody extends StatelessWidget {
  const FriendsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kPagePadding.w),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Gap(18.h), const FriendsViewHeader(), Gap(24.h)],
              ),
            ),
            const SliverToBoxAdapter(
              child: SectionHeader(text: "FRIEND REQUESTS (2)"),
            ),
            SliverToBoxAdapter(child: Gap(16.h)),
            const FriendReqsList(),
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
            const FriendsList(),
          ],
        ),
      ),
    );
  }
}
