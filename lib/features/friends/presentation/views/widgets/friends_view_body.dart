import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel_true_app/core/widgets/animated_snack_bar.dart';
import 'package:pixel_true_app/features/friends/presentation/managers/friends_cubit/friends_cubit.dart';
import 'package:pixel_true_app/features/friends/presentation/views/friends_loaded_view.dart';
import 'package:pixel_true_app/features/friends/presentation/views/friends_loading_view.dart';

class FriendsViewBody extends StatelessWidget {
  const FriendsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FriendsCubit, FriendsState>(
      buildWhen: (previous, current) {
        return current is FriendsViewLoaded || current is FriendsInitial;
      },
      listenWhen: (previous, current) {
        return current is FriendsFailure ||
            current is FriendRequestsFailure ||
            current is AcceptFriendRequestFailure ||
            current is DeclineFriendRequestFailure;
      },
      listener: (context, state) {
        if (state is FriendsFailure) {
          buildErrorSnackBar(context, message: state.errMessage);
        } else if (state is FriendRequestsFailure) {
          buildErrorSnackBar(context, message: state.errMessage);
        }
      },
      builder: (context, state) {
        if (state is FriendsViewLoaded) {
          return FriendsLoadedView(
            friends: state.friends,
            requests: state.requests,
          );
        }
        return const FriendsLoadingView();
      },
    );
  }
}
