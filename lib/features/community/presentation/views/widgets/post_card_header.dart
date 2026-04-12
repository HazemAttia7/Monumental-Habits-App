import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/widgets/custom_icon_button.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/user_meta_row.dart';

class PostCardHeader extends StatelessWidget {
  final String userName;
  final Duration postedSince;
  const PostCardHeader({
    super.key,
    required this.userName,
    required this.postedSince,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            UserMetaRow(userName: userName, postedSince: postedSince),
            CustomIconButton(
              onTap: () {
                // TODO : share post
              },
              icon: FontAwesomeIcons.share,
              iconSize: 16.sp,
              padding: EdgeInsets.all(12.sp),
            ),
          ],
        ),
        Gap(12.h),
        Divider(
          color: AppColors.primaryColor.withValues(alpha: .1),
          thickness: 2.w,
          height: 1,
        ),
        Gap(12.h),
      ],
    );
  }
}
