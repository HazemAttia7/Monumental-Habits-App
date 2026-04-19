import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/widgets/circle_divider.dart';
import 'package:pixel_true_app/core/widgets/profile_placeholder.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pixel_true_app/features/community/presentation/managers/replies_cubit/replies_cubit.dart';

class RepliesTeaser extends StatelessWidget {
  final VoidCallback onViewRepliesTap;
  const RepliesTeaser({super.key, required this.onViewRepliesTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 6.h),
      child: InkWell(
        onTap: onViewRepliesTap,
        borderRadius: BorderRadius.circular(12.r),
        splashColor: AppColors.secondaryColor.withValues(alpha: .1),
        highlightColor: AppColors.secondaryColor.withValues(alpha: .1),
        child: BlocBuilder<RepliesCubit, RepliesState>(
          buildWhen: (previous, current) => current is RepliesSuccess,
          builder: (context, state) {
            if (state is! RepliesSuccess || state.replies.isEmpty) {
              return const SizedBox.shrink();
            }
            final replies = state.replies;
            final currentUser = BlocProvider.of<AuthCubit>(
              context,
            ).currentUser!;
            final bool isCurrentUserReplied = replies.any(
              (reply) => reply.authorUid == currentUser.uid,
            );
            return isCurrentUserReplied
                ? Row(
                    children: [
                      ProfilePlaceholder(
                        userName: currentUser.name,
                        padding: EdgeInsets.all(2.sp),
                        width: 30.w,
                        height: 30.h,
                        fontSize: 12.sp,
                      ),
                      Gap(8.w),
                      Text(
                        "${currentUser.name} Replied",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gap(6.w),
                      const CircleDivider(),
                      Gap(6.w),
                      Text(
                        _getRepliesText(replies.length),
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                : Text(
                    _getViewRepliesText(replies.length),
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  );
          },
        ),
      ),
    );
  }

  _getViewRepliesText(int repliesLength) {
    if (repliesLength == 1) {
      return "View 1 reply";
    }
    return "View all $repliesLength replies";
  }

  _getRepliesText(int repliesLength) {
    if (repliesLength == 1) {
      return "1 reply";
    }
    return "$repliesLength replies";
  }
}
