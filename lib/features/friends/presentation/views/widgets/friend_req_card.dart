import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/enums/friends_enums.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/friends/data/models/friend_request_model.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/friend_req_info_row.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/req_actions.dart';

class FriendReqCard extends StatelessWidget {
  final FriendRequest friendReq;
  final enRequestType type;
  const FriendReqCard({super.key, required this.friendReq, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withValues(alpha: .4),
            blurRadius: 18,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        child: InkWell(
          onTap: () {
            // TODO : navigate to profile
          },
          borderRadius: BorderRadius.circular(16.r),
          splashColor: AppColors.primaryColor.withValues(alpha: .1),
          highlightColor: AppColors.primaryColor.withValues(alpha: .1),
          child: Container(
            padding: EdgeInsets.all(12.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: AppColors.primaryColor.withValues(alpha: .5),
                width: 2.w,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FriendReqInfoRow(username: friendReq.username),
                if (type == enRequestType.received)
                  ReqActions(request: friendReq),
                if (type == enRequestType.sent)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.sp,
                      vertical: 6.sp,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Text(
                      "PENDING",
                      style: AppStyles.textStyle14.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
