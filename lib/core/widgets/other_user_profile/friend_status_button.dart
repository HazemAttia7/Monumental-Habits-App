import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel_true_app/core/widgets/animated_snack_bar.dart';
import 'package:pixel_true_app/core/widgets/other_user_profile/request_action_buttons.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/likes_list/add_friend_button.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/likes_list/friends_button.dart';
import 'package:pixel_true_app/features/friends/presentation/managers/friends_cubit/friends_cubit.dart';

class FriendStatusButton extends StatefulWidget {
  final String uid;
  final String username;
  final bool isRequest;

  const FriendStatusButton({
    super.key,
    required this.uid,
    required this.username,
    required this.isRequest,
  });

  @override
  State<FriendStatusButton> createState() => _FriendStatusButtonState();
}

class _FriendStatusButtonState extends State<FriendStatusButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final friendsCubit = context.watch<FriendsCubit>();

    final isFriend = friendsCubit.isFriend(widget.uid);
    final hasReceivedRequest = friendsCubit.hasReceivedRequest(widget.uid);
    final hasSentRequest = friendsCubit.hasSentRequest(widget.uid);

    if (isFriend) {
      return const FriendsButton();
    }

    if (hasReceivedRequest) {
      final request = friendsCubit.getReceivedRequest(widget.uid)!;

      return RequestActionButtons(request: request, isReceived: true);
    }

    return BlocListener<FriendsCubit, FriendsState>(
      listener: (context, state) {
        if (state is SendFriendRequestFailure &&
            state.receiverId == widget.uid) {
          setState(() => _isLoading = false);
          buildErrorSnackBar(context, message: state.errMessage);
        } else if (state is SendFriendRequestLoading &&
            state.receiverId == widget.uid) {
          setState(() => _isLoading = true);
        } else if (state is SendFriendRequestSuccess &&
            state.receiverId == widget.uid) {
          setState(() => _isLoading = false);
          buildSuccessSnackBar(context, message: 'Friend request sent!');
        } else if (state is CancelFriendRequestFailure &&
            state.receiverId == widget.uid) {
          setState(() => _isLoading = false);
          buildErrorSnackBar(context, message: state.errMessage);
        } else if (state is CancelFriendRequestLoading &&
            state.receiverId == widget.uid) {
          setState(() => _isLoading = true);
        } else if (state is CancelFriendRequestSuccess &&
            state.receiverId == widget.uid) {
          setState(() => _isLoading = false);
          buildSuccessSnackBar(context, message: 'Friend request cancelled!');
        }
        // Note: we no longer flip a local "_isPending" flag on success.
        // hasSentRequest is derived from FriendsCubit's live _sentRequests
        // stream, so the button's pending state updates automatically
        // whenever a FriendsViewLoaded state comes through — even if the
        // request was sent from a different widget/screen entirely.
      },
      child: AddFriendButton(
        uid: widget.uid,
        isPending: hasSentRequest,
        isLoading: _isLoading,
        username: widget.username,
        isfullWidth: true,
      ),
    );
  }
}
