import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/core/helper/service_locator.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_router.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/profile_placeholder.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pixel_true_app/features/community/helper/get_time_ago.dart';
import 'package:pixel_true_app/features/friends/data/repos/friends_repo.dart';
import 'package:pixel_true_app/features/friends/presentation/managers/friends_cubit/friends_cubit.dart';
import 'package:provider/provider.dart';

class UserMetaRow extends StatelessWidget {
  final String username;
  final String? authorUid;
  final String? displayName;
  final Duration? postedSince;
  final Color? backColor;
  const UserMetaRow({
    super.key,
    required this.username,
    this.postedSince,
    this.displayName,
    this.backColor,
    this.authorUid,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap:
              (authorUid == null ||
                  context.read<AuthCubit>().currentUser!.uid == authorUid)
              ? null
              : () => GoRouter.of(context).push(
                  AppRouter.kUserProfile,
                  extra: {
                    "uid": authorUid,
                    "cubit": FriendsCubit(sl<FriendsRepo>())
                      ..getFriends()
                      ..getOutgoingFriendRequests()
                      ..getIncomingFriendRequests()
                      ..getPendingRequestIds(),
                  },
                ),
          child: ProfilePlaceholder(
            width: 34.w,
            height: 34.h,
            fontSize: 14.sp,
            padding: EdgeInsets.all(2.sp),
            username: username,
            backColor: backColor,
          ),
        ),
        Gap(10.w),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              displayName ?? username,
              style: AppStyles.textStyle14.copyWith(
                fontWeight: FontWeight.bold,
                height: 1.15,
              ),
            ),
            if (postedSince != null)
              Text(
                getTimeAgo(postedSince!),
                style: AppStyles.textStyle12.copyWith(
                  color: AppColors.secondaryColor.withValues(alpha: .5),
                  height: 1.15,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
