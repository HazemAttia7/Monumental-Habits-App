import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/core/enums/friends_enums.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_router.dart';
import 'package:pixel_true_app/features/friends/data/models/friend_request_model.dart';
import 'package:pixel_true_app/features/friends/presentation/managers/friends_cubit/friends_cubit.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/sender_req_actions.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/user_info_row.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/received_req_actions.dart';
import 'package:provider/provider.dart';

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
          onTap: () => GoRouter.of(context).push(
            AppRouter.kUserProfile,
            extra: {
              "uid": friendReq.userId,
              "isRequest": true,
              "request": friendReq,
              "isReceived": type == enRequestType.received,
              "cubit": context.read<FriendsCubit>(),
            },
          ),
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
              children: [
                Expanded(child: UserInfoRow(username: friendReq.username)),
                if (type == enRequestType.received)
                  ReceivedReqActions(request: friendReq),
                if (type == enRequestType.sent)
                  SentReqActions(request: friendReq),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
