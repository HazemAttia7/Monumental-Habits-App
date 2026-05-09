import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/friend_req_info_row.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/req_actions.dart';

class FriendReqCard extends StatelessWidget {
  // final FriendRequest friendReq;
  const FriendReqCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.primaryColor.withValues(alpha: .5),
          width: 2.w,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withValues(alpha: .4),
            blurRadius: 12,
            spreadRadius: 2,
            offset: Offset.zero,
          ),
        ],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [FriendReqInfoRow(), ReqActions()],
      ),
    );
  }
}
