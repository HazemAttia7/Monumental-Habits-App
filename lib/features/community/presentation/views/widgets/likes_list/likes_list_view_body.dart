import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/core/widgets/default_view_header.dart';
import 'package:pixel_true_app/features/community/presentation/managers/likes_list_cubit/likes_list_cubit.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/likes_list/shimmer/users_list_shimmer.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/likes_list/user_list.dart';
import 'package:pixel_true_app/features/friends/presentation/managers/friends_cubit/friends_cubit.dart';

class LikesListViewBody extends StatelessWidget {
  const LikesListViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kPagePadding.w),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Gap(12.h),
                  const DefaultViewHeader(title: 'Liked By'),
                  Gap(24.h),
                ],
              ),
            ),

            BlocBuilder<LikesListCubit, LikesListState>(
              builder: (context, likesState) {
                return BlocBuilder<FriendsCubit, FriendsState>(
                  builder: (context, friendsState) {
                    final isLikesLoading = likesState is LikesListLoading;
                    final isFriendsLoading = friendsState is FriendsInitial;

                    if (isLikesLoading || isFriendsLoading) {
                      return const SliverToBoxAdapter(
                        child: UsersListShimmer(),
                      );
                    }

                    if (likesState is LikesListFailure) {
                      return SliverToBoxAdapter(
                        child: Center(
                          child: Text(
                            likesState.message,
                            style: AppStyles.textStyle17,
                          ),
                        ),
                      );
                    }

                    if (likesState is LikesListSuccess) {
                      return UsersList(users: likesState.users);
                    }

                    return const SliverToBoxAdapter(child: SizedBox());
                  },
                );
              },
            ),

            SliverToBoxAdapter(child: Gap(100.h)),
          ],
        ),
      ),
    );
  }
}
