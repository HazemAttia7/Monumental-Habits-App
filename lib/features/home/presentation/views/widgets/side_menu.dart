import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/more_actions.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/side_menu_close_button.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/side_menu_list_tile.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/upgrade_to_pro_button.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.83.sw,
      decoration: BoxDecoration(
        color: AppColors.scaffoldColor2,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(48.r),
          bottomRight: Radius.circular(48.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Gap(12.h),
            const SideMenuCloseButton(),
            const Spacer(flex: 3),
            SideMenuListTile(
              icon: FontAwesomeIcons.solidUser,
              title: "Profile",
              onTap: () {
                // TODO : Open Profile view
              },
            ),
            Gap(24.h),
            SideMenuListTile(
              icon: FontAwesomeIcons.solidRectangleList,
              title: "Activity Log",
              onTap: () {
                // TODO : Open Activity Log (Comments , liked comments , posts , like pots , saved courses)
              },
            ),
            Gap(24.h),
            SideMenuListTile(
              icon: FontAwesomeIcons.clockRotateLeft,
              title: "Habits History",
              onTap: () {
                // TODO : Open Habits History
              },
            ),
            Gap(24.h),
            SideMenuListTile(
              icon: FontAwesomeIcons.users,
              title: "Friends",
              onTap: () {
                // TODO : Open Friends list
              },
            ),
            Gap(24.h),
            SideMenuListTile(
              icon: FontAwesomeIcons.circleQuestion,
              title: "Support",
              onTap: () {
                // TODO : Open Support
              },
            ),
            const Spacer(flex: 4),
            UpgradeToProButton(onTap: () {}),
            Gap(36.h),
            const MoreActions(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
