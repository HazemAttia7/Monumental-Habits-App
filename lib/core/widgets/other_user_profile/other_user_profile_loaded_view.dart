import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/widgets/default_view_header.dart';
import 'package:pixel_true_app/core/widgets/other_user_profile/friend_status_button.dart';
import 'package:pixel_true_app/core/widgets/other_user_profile/orher_user_habit_analytics_sliver_list.dart';
import 'package:pixel_true_app/core/widgets/other_user_profile/other_user_profile_summary.dart';
import 'package:pixel_true_app/models/user_profile_model.dart';

class OtherUserProfileLoadedView extends StatelessWidget {
  const OtherUserProfileLoadedView({
    super.key,
    required this.profile,
    required this.isRequest,
  });

  final UserProfile profile;
  final bool? isRequest;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              Gap(10.h),
              DefaultViewHeader(title: "${profile.username}'s Profile"),
              Gap(24.h),
              FriendStatusButton(
                isRequest: isRequest ?? false,
                uid: profile.uid,
                username: profile.username,
              ),
              Gap(16.h),
              OtherUserProfileSummary(username: profile.username),
              Gap(16.h),
            ],
          ),
        ),
        const OtherUserHabitsAnalyticsSliverList(),
      ],
    );
  }
}
