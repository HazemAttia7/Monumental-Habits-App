import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/core/managers/cubits/habits_cubit/habits_cubit.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_router.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/more_actions.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/side_menu_close_button.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/side_menu_list_tile.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/upgrade_to_pro_button.dart';
import 'package:provider/provider.dart';

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
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Gap(12.h),
                const SideMenuCloseButton(),
                Gap(48.h),
                SideMenuListTile(
                  icon: FontAwesomeIcons.solidUser,
                  title: "Profile",
                  onTap: () => GoRouter.of(context).push(
                    AppRouter.kProfileView,
                    extra: context.read<HabitsCubit>(),
                  ),
                ),
                Gap(24.h),
                SideMenuListTile(
                  icon: FontAwesomeIcons.solidRectangleList,
                  title: "Activity Log",
                  onTap: () {},
                ),
                Gap(24.h),
                SideMenuListTile(
                  icon: FontAwesomeIcons.clockRotateLeft,
                  title: "Habits History",
                  onTap: () => GoRouter.of(context).push(
                    AppRouter.kHabitsHistory,
                    extra: context.read<HabitsCubit>(),
                  ),
                ),
                Gap(24.h),
                SideMenuListTile(
                  icon: FontAwesomeIcons.users,
                  title: "Friends",
                  onTap: () => GoRouter.of(context).push(AppRouter.kFriends),
                ),
                Gap(24.h),
                SideMenuListTile(
                  icon: FontAwesomeIcons.circleQuestion,
                  title: "Support",
                  onTap: () => GoRouter.of(context).push(AppRouter.kSupport),
                ),
                Gap(64.h),
                UpgradeToProButton(
                  onTap: () => GoRouter.of(context).push(AppRouter.kSubcrption),
                ),
                Gap(36.h),
                const MoreActions(),
                Gap(16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
