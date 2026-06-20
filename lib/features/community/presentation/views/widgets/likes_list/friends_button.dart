import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/friends/presentation/managers/friends_cubit/friends_cubit.dart';
import 'package:provider/provider.dart';

class FriendsButton extends StatelessWidget {
  final String friendUid;
  const FriendsButton({super.key, required this.friendUid});

  @override
  Widget build(BuildContext context) {
    debugPrint("friendUid: $friendUid");
    return Material(
      color: const Color(0xffFEEAFA),
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        onTap: () =>
            context.read<FriendsCubit>().removeFriend(friendId: friendUid),
        borderRadius: BorderRadius.circular(16.r),
        splashColor: AppColors.secondaryColor.withValues(alpha: .1),
        highlightColor: AppColors.secondaryColor.withValues(alpha: .1),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 6.sp),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r)),
          child: Row(
            spacing: 8.w,
            children: [
              Icon(
                FontAwesomeIcons.check,
                size: 17.sp,
                color: AppColors.secondaryColor,
              ),
              Text(
                "FRIENDS",
                style: AppStyles.textStyle14.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
