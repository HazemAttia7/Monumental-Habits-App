import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/friends/presentation/views/widgets/friend_req_info_row.dart';

class FriendCard extends StatelessWidget {
  const FriendCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
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
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const FriendReqInfoRow(),
              Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.fireFlameCurved,
                        color: AppColors.primaryColor,
                        size: 24.sp,
                      ),
                      Gap(4.w),
                      Text(
                        "24",
                        style: AppStyles.textStyle20.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Best Streak",
                    style: AppStyles.textStyle14.copyWith(color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
