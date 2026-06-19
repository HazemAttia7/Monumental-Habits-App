import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/shimmer/friends_req_card_shimmer.dart';

class FriendReqsListShimmer extends StatelessWidget {
  final int listCount;
  final String requestType;
  const FriendReqsListShimmer({
    super.key,
    this.listCount = 3,
    required this.requestType,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (_, index) => Container(
        padding: EdgeInsets.all(12.sp),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: AppColors.primaryColor.withValues(alpha: .5),
            width: 1.w,
          ),
        ),
        child: FriendsReqCardShimmer(requestType: requestType),
      ),
      separatorBuilder: (_, __) => Gap(16.h),
      itemCount: listCount,
    );
  }
}
