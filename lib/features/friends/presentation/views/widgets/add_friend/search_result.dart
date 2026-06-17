import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pixel_true_app/features/friends/presentation/managers/user_search_cubit/user_search_cubit.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/users_list_with_friends_status.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUid = context.read<AuthCubit>().currentUser!.uid;

    return BlocBuilder<UserSearchCubit, UserSearchState>(
      builder: (context, state) {
        if (state is UserSearchLoading) {
          return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is UserSearchFailure) {
          return SliverToBoxAdapter(child: Center(child: Text(state.message)));
        }
        if (state is UserSearchResults) {
          final results = state.users
              .where((u) => u.uid != currentUid)
              .toList();

          if (results.isEmpty) {
            return const SliverToBoxAdapter(
              child: Center(child: Text('No users found')),
            );
          }

          return UsersListWithFriendStatus(users: results);
        }
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}
