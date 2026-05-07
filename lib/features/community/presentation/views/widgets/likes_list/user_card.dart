import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/likes_list/add_fiend_button.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/likes_list/liked_by_user_info.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [LikeByUserInfo(), AddFriendButton()],
      ),
    );
  }
}
