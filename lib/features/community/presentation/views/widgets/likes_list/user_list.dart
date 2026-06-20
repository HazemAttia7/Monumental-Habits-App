import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/users_list_with_friends_status.dart';
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

    return UsersListWithFriendStatus(users: sortedUsers);
  }
}
