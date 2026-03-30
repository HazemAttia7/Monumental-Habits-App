import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/support/presentation/managers/support_view_controller.dart';
import 'package:pixel_true_app/features/support/presentation/views/widgets/faq_widget.dart';
import 'package:provider/provider.dart';

class FAQSection extends StatelessWidget {
  const FAQSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SupportViewController>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Frequently Asked Questions", style: AppStyles.textStyle18),
          Gap(18.h),
          Column(
            children: List.generate(
              controller.faqs.length,
              (index) => FAQWidget(
                faq: controller.faqs[index],
                expansionCallback: (_, isExpanded) =>
                    controller.toggleExpansion(isExpanded, index),
                isOpen: controller.isOpen[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
