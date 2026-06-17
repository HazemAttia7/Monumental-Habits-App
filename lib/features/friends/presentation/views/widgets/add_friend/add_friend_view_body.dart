import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/core/widgets/default_view_header.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/likes_list/user_card.dart';
import 'package:pixel_true_app/features/friends/presentation/managers/friends_cubit/friends_cubit.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/custom_search_field.dart';

class AddFriendViewBody extends StatelessWidget {
  const AddFriendViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUid = context.read<AuthCubit>().currentUser!.uid;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kPagePadding.w),
        child: Column(
          children: [
            Gap(18.h),
            const DefaultViewHeader(title: "Add Friend"),
            Gap(12.h),
            CustomSearchField(
              onChanged: (value) =>
                  context.read<FriendsCubit>().searchUsers(value),
              hintText: "Search for friends by username...",
            ),
            Gap(12.h),
            Expanded(
              child: BlocBuilder<FriendsCubit, FriendsState>(
                builder: (context, state) {
                  if (state is UserSearchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is UserSearchFailure) {
                    return Center(child: Text(state.message));
                  }

                  if (state is UserSearchResults) {
                    final results = state.users
                        .where((u) => u.uid != currentUid)
                        .toList();

                    if (results.isEmpty) {
                      return const Center(child: Text('No users found'));
                    }

                    return ListView.separated(
                      itemBuilder: (_, index) {
                        final user = results[index];
                        return UserCard(
                          user: user,
                          isFriend: false,
                          isPending: context
                              .read<FriendsCubit>()
                              .pendingIds
                              .contains(user.uid),
                        );
                      },
                      separatorBuilder: (_, __) => Gap(18.h),
                      itemCount: results.length,
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
