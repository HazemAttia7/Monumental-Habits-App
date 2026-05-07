import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/likes_list/add_fiend_button.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/likes_list/friends_button.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/likes_list/liked_by_user_info.dart';
import 'package:pixel_true_app/models/user_profile_model.dart';

class UserCard extends StatelessWidget {
  final UserProfile user;
  final bool isFriend;
  const UserCard({super.key, required this.user, this.isFriend = false});

  @override
  Widget build(BuildContext context) {
    final isCurrentUser =
        user.uid == context.read<AuthCubit>().currentUser!.uid;

    return Container(
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LikeByUserInfo(userName: user.username, isCurrentUser: isCurrentUser),
          isCurrentUser
              ? const SizedBox()
              : isFriend
              ? const FriendsButton()
              : AddFriendButton(uid: user.uid),
        ],
      ),
    );
  }
}
