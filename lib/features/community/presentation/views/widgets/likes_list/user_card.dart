import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/widgets/animated_snack_bar.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/likes_list/add_friend_button.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/likes_list/friends_button.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/likes_list/liked_by_user_info.dart';
import 'package:pixel_true_app/features/friends/presentation/managers/friends_cubit/friends_cubit.dart';
import 'package:pixel_true_app/models/user_profile_model.dart';

class UserCard extends StatefulWidget {
  final UserProfile user;
  final bool isFriend, isPending;
  const UserCard({
    super.key,
    required this.user,
    this.isFriend = false,
    this.isPending = false,
  });

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  bool _isLoading = false;
  late bool _isPending;

  @override
  void initState() {
    super.initState();
    _isPending = widget.isPending;
  }

  @override
  void didUpdateWidget(covariant UserCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isPending != widget.isPending) {
      _isPending = widget.isPending;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isCurrentUser =
        widget.user.uid == context.read<AuthCubit>().currentUser!.uid;

    return Container(
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LikeByUserInfo(
            userName: widget.user.username,
            isCurrentUser: isCurrentUser,
          ),
          isCurrentUser
              ? const SizedBox()
              : widget.isFriend
              ? const FriendsButton()
              : BlocListener<FriendsCubit, FriendsState>(
                  listener: (context, state) {
                    if (state is SendFriendRequestSuccess &&
                        state.receiverId == widget.user.uid) {
                      setState(() {
                        _isLoading = false;
                        _isPending = true;
                      });
                      buildSuccessSnackBar(
                        context,
                        message: 'Friend request sent!',
                      );
                    } else if (state is SendFriendRequestFailure &&
                        state.receiverId == widget.user.uid) {
                      setState(() => _isLoading = false);
                      buildErrorSnackBar(context, message: state.errMessage);
                    } else if (state is SendFriendRequestLoading &&
                        state.receiverId == widget.user.uid) {
                      setState(() => _isLoading = true);
                    } else if (state is CancelFriendRequestSuccess &&
                        state.receiverId == widget.user.uid) {
                      setState(() {
                        _isLoading = false;
                        _isPending = false;
                      });
                      buildSuccessSnackBar(
                        context,
                        message: 'Friend request cancelled!',
                      );
                    } else if (state is CancelFriendRequestFailure &&
                        state.receiverId == widget.user.uid) {
                      setState(() => _isLoading = false);
                      buildErrorSnackBar(context, message: state.errMessage);
                    } else if (state is CancelFriendRequestLoading &&
                        state.receiverId == widget.user.uid) {
                      setState(() => _isLoading = true);
                    }
                  },
                  child: AddFriendButton(
                    uid: widget.user.uid,
                    isPending: _isPending,
                    isLoading: _isLoading,
                  ),
                ),
        ],
      ),
    );
  }
}
