import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/core/widgets/default_view_header.dart';
import 'package:pixel_true_app/features/connect/presentation/views/widgets/collab_card.dart';
import 'package:pixel_true_app/features/connect/presentation/views/widgets/find_me_online_section.dart';

class ConnectViewBody extends StatelessWidget {
  const ConnectViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kPagePadding.w),
          child: DefaultTextStyle(
            style: AppStyles.textStyle14.copyWith(
              fontFamily: 'Klasik',
              color: AppColors.secondaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(12.h),
                const DefaultViewHeader(title: "Connect"),
                Gap(24.h),
                const CollabCard(),
                Gap(32.h),
                const FindMeOnlineSection(),
                Gap(16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
