import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/custom_icon_button.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/user_info_row.dart';
import 'package:shimmer/shimmer.dart';

class FriendsReqCardShimmer extends StatelessWidget {
  final String requestType;
  const FriendsReqCardShimmer({super.key, required this.requestType});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: const UserInfoRow(username: "user"),
          ),
        ),
        requestType == "sent"
            ? const SentReqActionsShimmer()
            : const ReceivedReqActionsShimmer(),
      ],
    );
  }
}

class SentReqActionsShimmer extends StatelessWidget {
  const SentReqActionsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Row(
        spacing: 12.w,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomIconButton(
            iconColor: AppColors.primaryColor,
            backColor: AppColors.primaryColor.withValues(alpha: .1),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16.r),
            icon: FontAwesomeIcons.xmark,
            onTap: () {},
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 6.sp),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Text(
              "PENDING",
              style: AppStyles.textStyle14.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ReceivedReqActionsShimmer extends StatelessWidget {
  const ReceivedReqActionsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomIconButton(
            iconColor: AppColors.primaryColor,
            backColor: AppColors.primaryColor.withValues(alpha: .1),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16.r),
            icon: FontAwesomeIcons.xmark,
            onTap: () {},
          ),
          Gap(8.w),
          CustomIconButton(
            iconColor: AppColors.primaryColor,
            backColor: AppColors.primaryColor.withValues(alpha: .1),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16.r),
            icon: FontAwesomeIcons.check,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
