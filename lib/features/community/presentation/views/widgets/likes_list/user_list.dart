import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/likes_list/shimmer/users_list_shimmer.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/likes_list/user_card.dart';
import 'package:pixel_true_app/features/friends/presentation/managers/friends_cubit/friends_cubit.dart';
import 'package:pixel_true_app/models/user_profile_model.dart';

class UsersList extends StatelessWidget {
  final List<UserProfile> users;
  const UsersList({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    final currentUid = context.read<AuthCubit>().currentUser!.uid;

    final sortedUsers = [...users];

    final currentUserIndex = sortedUsers.indexWhere((x) => x.uid == currentUid);

    UserProfile? currentUser;
    if (currentUserIndex != -1) {
      currentUser = sortedUsers.removeAt(currentUserIndex);
      sortedUsers.insert(0, currentUser);
    }

    return BlocBuilder<FriendsCubit, FriendsState>(
      buildWhen: (_, state) => state is PendingIdsLoaded,
      builder: (context, state) {
        if (state is! PendingIdsLoaded) {
          return const SliverToBoxAdapter(child: UsersListShimmer());
        }

        return SliverList.separated(
          itemBuilder: (_, index) {
            final user = sortedUsers[index];
            return UserCard(
              user: user,
              isFriend: currentUser?.isFriend(sortedUsers[index].uid) ?? false,
              isPending: context.read<FriendsCubit>().pendingIds.contains(
                user.uid,
              ),
            );
          },
          separatorBuilder: (_, __) => Gap(18.h),
          itemCount: sortedUsers.length,
        );
      },
    );
  }
}
