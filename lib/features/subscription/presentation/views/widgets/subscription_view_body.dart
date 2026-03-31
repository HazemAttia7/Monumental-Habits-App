import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/core/widgets/default_view_header.dart';
import 'package:pixel_true_app/features/subscription/presentation/views/widgets/offer_widget.dart';
import 'package:pixel_true_app/features/subscription/presentation/views/widgets/premium_features.dart';

class SubscriptionViewBody extends StatelessWidget {
  const SubscriptionViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kPagePadding.w),
        child: Column(
          children: [
            Gap(12.h),
            const DefaultViewHeader(title: "Premium"),
            Gap(24.h),
            const OfferWidget(),
            Gap(12.h),
            const PremiumFeatures(),
          ],
        ),
      ),
    );
  }
}
