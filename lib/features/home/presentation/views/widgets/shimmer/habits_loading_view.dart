import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/core/widgets/profile_placeholder.dart';
import 'package:pixel_true_app/core/widgets/shimmer/image_shimmer.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/shimmer/habitS_tracking_list_shimmer.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/shimmer/habits_section_header_shimmer.dart';

class HabitsLoadingView extends StatelessWidget {
  const HabitsLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Gap(10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kPagePadding.sp),
              child: const _HomeHeader(),
            ),
            Gap(24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kPagePadding.sp),
              child: ImageShimmer(height: 140.h, borderRadius: 12.r),
            ),
            Gap(19.h),
            Padding(
              padding: EdgeInsets.only(left: (kPagePadding + 18).sp),
              child: const HabitsSectionHeaderShimmer(),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: kPagePadding.sp,
                top: 13.h,
                bottom: 140.sp,
              ),
              child: const HabitsTrackingListShimmer(),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.all(11.sp),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.secondaryColor.withValues(alpha: .1),
          ),
          child: Icon(
            FontAwesomeIcons.equals,
            color: AppColors.secondaryColor,
            size: 22.sp,
          ),
        ),
        Text("Home Page", style: AppStyles.textStyle18),
        ProfilePlaceholder(
          userName: context.watch<AuthCubit>().currentUser?.name ?? "",
        ),
      ],
    );
  }
}
