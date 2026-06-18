import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/custom_icon_button.dart';
import 'package:pixel_true_app/features/friends/data/models/friend_request_model.dart';
import 'package:pixel_true_app/features/friends/presentation/managers/friends_cubit/friends_cubit.dart';

class SentReqActions extends StatelessWidget {
  final FriendRequest request;
  const SentReqActions({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12.w,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomIconButton(
          iconColor: AppColors.primaryColor,
          backColor: AppColors.primaryColor.withValues(alpha: .1),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16.r),
          icon: FontAwesomeIcons.xmark,
          onTap: () => BlocProvider.of<FriendsCubit>(
            context,
          ).deleteFriendRequest(senderId: request.userId),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 6.sp),
          decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Text(
            "PENDING",
            style: AppStyles.textStyle14.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
