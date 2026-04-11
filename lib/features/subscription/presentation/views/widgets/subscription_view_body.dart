import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/helper/build_not_implemented_yet_dialog.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/core/widgets/custom_button.dart';
import 'package:pixel_true_app/core/widgets/default_view_header.dart';
import 'package:pixel_true_app/core/widgets/custom_clickable_text.dart';
import 'package:pixel_true_app/features/subscription/presentation/views/widgets/offer_widget.dart';
import 'package:pixel_true_app/features/subscription/presentation/views/widgets/plans_section.dart';
import 'package:pixel_true_app/features/subscription/presentation/views/widgets/premium_features.dart';
import 'package:pixel_true_app/features/subscription/presentation/views/widgets/secured_with_google_widget.dart';

class SubscriptionViewBody extends StatelessWidget {
  const SubscriptionViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kPagePadding.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Gap(12.h),
              const DefaultViewHeader(title: "Premium"),
              Gap(24.h),
              const OfferWidget(),
              Gap(12.h),
              const PremiumFeatures(),
              Gap(24.h),
              const PlansSection(),
              Gap(48.h),
              CustomButton(
                onTap: () => buildNotImplementedYetDialog(
                  context,
                  featureName: "Subscription",
                ),
                text: "Subscribe Now",
              ),
              Gap(16.h),
              const SecuredWithGoogleWidget(),
              Gap(36.h),
              CustomClickableText(
                text: "Restore Purchase",
                onTap: () => buildNotImplementedYetDialog(
                  context,
                  featureName: "Restore Purchase",
                ),
                fontSize: 12.sp,
                textDecoration: TextDecoration.underline,
              ),
              Gap(8.h),
              Text.rich(
                TextSpan(
                  children: [
                    _buildClickableText(
                      text: "Terms of Service",
                      onTap: () => buildNotImplementedYetDialog(
                        context,
                        featureName: "Terms of Service",
                      ),
                    ),
                    TextSpan(
                      text: " and ",
                      style: AppStyles.textStyle12.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.secondaryColor.withValues(alpha: .5),
                      ),
                    ),
                    _buildClickableText(
                      text: "Privacy Policy",
                      onTap: () => buildNotImplementedYetDialog(
                        context,
                        featureName: "Privacy Policy",
                      ),
                    ),
                  ],
                ),
              ),
              Gap(20.h),
            ],
          ),
        ),
      ),
    );
  }

  WidgetSpan _buildClickableText({
    required String text,
    required VoidCallback onTap,
  }) {
    return WidgetSpan(
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        splashColor: AppColors.secondaryColor.withValues(alpha: .1),
        highlightColor: AppColors.secondaryColor.withValues(alpha: .1),
        onTap: onTap,
        child: Text(
          text,
          style: AppStyles.textStyle10.copyWith(
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            decorationThickness: 3.sp,
          ),
        ),
      ),
    );
  }
}
