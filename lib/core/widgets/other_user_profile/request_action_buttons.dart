import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/friends/data/models/friend_request_model.dart';
import 'package:pixel_true_app/features/friends/presentation/managers/friends_cubit/friends_cubit.dart';

class RequestActionButtons extends StatelessWidget {
  const RequestActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final extra = GoRouterState.of(context).extra as Map<String, dynamic>?;
    final request = extra?['request'] as FriendRequest?;
    final isReceived = extra?['isReceived'] as bool?;
    
    return Column(
      spacing: 12.h,
      children: [
        if (isReceived ?? false)
          _Button(
            text: 'ACCEPT REQUEST',
            backColor: AppColors.primaryColor,
            foregroundColor: Colors.white,
            onTap: () =>
                BlocProvider.of<FriendsCubit>(context).acceptFriendRequest(
                  senderId: request!.userId,
                  senderUsername: request.username,
                  senderBestStreak: request.bestStreak,
                ),
            icon: FontAwesomeIcons.check,
          ),
        _Button(
          text: 'DECLINE REQUEST',
          backColor: AppColors.primaryColor.withValues(alpha: .1),
          foregroundColor: AppColors.primaryColor,
          onTap: () =>
              BlocProvider.of<FriendsCubit>(context).acceptFriendRequest(
                senderId: request!.userId,
                senderUsername: request.username,
                senderBestStreak: request.bestStreak,
              ),
          icon: FontAwesomeIcons.xmark,
        ),
      ],
    );
  }
}

class _Button extends StatelessWidget {
  final String text;
  final Color backColor, foregroundColor;
  final VoidCallback onTap;
  final IconData icon;
  const _Button({
    required this.text,
    required this.backColor,
    required this.foregroundColor,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backColor,
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        splashColor: AppColors.primaryColor.withValues(alpha: .1),
        highlightColor: AppColors.primaryColor.withValues(alpha: .1),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 6.sp),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r)),
          child: Row(
            spacing: 8.w,
            children: [
              Icon(icon, size: 17.sp, color: foregroundColor),
              Text(
                text,
                style: AppStyles.textStyle14.copyWith(
                  color: foregroundColor,
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
