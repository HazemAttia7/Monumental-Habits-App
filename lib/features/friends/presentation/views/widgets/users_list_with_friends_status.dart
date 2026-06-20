import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/likes_list/user_card.dart';
import 'package:pixel_true_app/features/friends/presentation/managers/friends_cubit/friends_cubit.dart';
import 'package:pixel_true_app/models/user_profile_model.dart';

class UsersListWithFriendStatus extends StatelessWidget {
  final List<UserProfile> users;

  const UsersListWithFriendStatus({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FriendsCubit, FriendsState>(
      builder: (context, state) {
        final friendsCubit = context.read<FriendsCubit>();

        return SliverList.separated(
          itemCount: users.length,
          separatorBuilder: (_, __) => Gap(18.h),
          itemBuilder: (_, index) {
            final user = users[index];

            return UserCard(
              user: user,
              isFriend: friendsCubit.isFriend(user.uid),
              isPending: friendsCubit.hasSentRequest(user.uid),
            );
          },
        );
      },
    );
  }
}
