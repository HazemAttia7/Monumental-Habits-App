import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/widgets/custom_icon_button.dart';
import 'package:pixel_true_app/features/friends/data/models/friend_request_model.dart';
import 'package:pixel_true_app/features/friends/presentation/managers/friends_cubit/friends_cubit.dart';

class ReqActions extends StatelessWidget {
  final FriendRequest request;
  const ReqActions({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomIconButton(
          iconColor: AppColors.primaryColor,
          backColor: AppColors.primaryColor.withValues(alpha: .1),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16.r),
          icon: FontAwesomeIcons.xmark,
          onTap: () => BlocProvider.of<FriendsCubit>(
            context,
          ).declineFriendRequest(senderId: request.userId),
        ),
        Gap(8.w),
        CustomIconButton(
          iconColor: Colors.white,
          backColor: AppColors.primaryColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16.r),
          icon: FontAwesomeIcons.check,
          onTap: () =>
              BlocProvider.of<FriendsCubit>(context).acceptFriendRequest(
                senderId: request.userId,
                senderUsername: request.username,
                senderBestStreak: request.bestStreak,
              ),
        ),
      ],
    );
  }
}
