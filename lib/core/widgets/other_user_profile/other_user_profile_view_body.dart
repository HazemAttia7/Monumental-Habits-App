import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/core/widgets/default_view_header.dart';
import 'package:pixel_true_app/core/widgets/other_user_profile/friend_status_button.dart';
import 'package:pixel_true_app/core/widgets/other_user_profile/orher_user_habit_analytics_sliver_list.dart';
import 'package:pixel_true_app/core/widgets/other_user_profile/other_user_profile_summary.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/user_profile_cubit/user_profile_cubit.dart';

class OtherUserProfileViewBody extends StatelessWidget {
  const OtherUserProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final extra = GoRouterState.of(context).extra as Map<String, dynamic>?;
    final isRequest = extra?['isRequest'] as bool?;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kPagePadding.w),
        child: BlocBuilder<UserProfileCubit, UserProfileState>(
          builder: (context, state) {
            if (state is UserProfileLoading || state is UserProfileInitial) {
              // TODO : add shimmer effect
              return const Center(child: CircularProgressIndicator());
            }

            if (state is UserProfileError) {
              return Center(child: Text(state.errMessage));
            }

            final profile = (state as UserProfileLoaded).userProfile;

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
          },
        ),
      ),
    );
  }
}
