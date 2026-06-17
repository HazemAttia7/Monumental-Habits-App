import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/friends/presentation/managers/friends_cubit/friends_cubit.dart';
import 'package:provider/provider.dart';

class AddFriendButton extends StatelessWidget {
  final String uid , username;
  final bool isPending, isLoading;
  const AddFriendButton({
    super.key,
    required this.uid,
    this.isPending = false,
    this.isLoading = false, required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isLoading,
      child: Material(
        color: isPending ? AppColors.secondaryColor : AppColors.morning,
        borderRadius: BorderRadius.circular(16.r),
        child: InkWell(
          onTap: isPending
              ? () => context.read<FriendsCubit>().cancelFriendRequest(
                  receiverId: uid,
                )
              : () => context.read<FriendsCubit>().sendFriendRequest(
                  receiverUsername: username,
                  receiverId: uid,
                ),
          borderRadius: BorderRadius.circular(16.r),
          splashColor: AppColors.secondaryColor.withValues(alpha: .1),
          highlightColor: AppColors.secondaryColor.withValues(alpha: .1),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 6.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Text(
              isLoading
                  ? "SENDING..."
                  : isPending
                  ? "PENDING"
                  : "ADD FRIEND",
              style: AppStyles.textStyle14.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
