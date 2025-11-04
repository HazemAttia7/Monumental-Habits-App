import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/onboarding/presentation/views/widgets/animated_page_indicator.dart';

class OnboardingControls extends StatelessWidget {
  final int pagesNum;
  final int selectedPageIndex;
  final PageController pageController;
  const OnboardingControls({
    super.key,
    required this.pageController,
    required this.pagesNum,
    required this.selectedPageIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(10.r),
            onTap: () {
              pageController.animateToPage(
                pagesNum - 1,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOut,
              );
            },
            child: Text("Skip", style: AppStyles.textStyle17),
          ),
          AnimatedPageIndicator(
            pagesNum: pagesNum,
            selectedPageIndex: selectedPageIndex,
            pageController: pageController,
          ),
          InkWell(
            borderRadius: BorderRadius.circular(10.r),
            onTap: () {
              pageController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            child: Text("Next", style: AppStyles.textStyle17),
          ),
        ],
      ),
    );
  }
}
