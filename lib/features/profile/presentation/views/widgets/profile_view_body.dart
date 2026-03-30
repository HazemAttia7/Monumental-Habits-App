import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/core/widgets/icon_tile_card.dart';
import 'package:pixel_true_app/features/profile/presentation/managers/profile_view_controller.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/profile_header.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/profile_summary.dart';
import 'package:provider/provider.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ProfileViewController>();
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kPagePadding.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Gap(10.h),
              const ProfileHeader(),
              Gap(32.h),
              const ProfileSummary(),
              Gap(8.h),
              IconTileCard(
                icon: FontAwesomeIcons.solidCreditCard,
                title: "Biiling Methods",
                onTap: () => controller.onBillingMethodsTap(context),
              ),
              Gap(8.h),
              IconTileCard(
                icon: FontAwesomeIcons.medal,
                title: "Habits Analytics",
                onTap: () => controller.onHabitsAnalyticsTap(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
