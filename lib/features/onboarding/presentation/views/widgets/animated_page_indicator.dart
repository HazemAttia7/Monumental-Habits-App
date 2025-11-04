import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';

class AnimatedPageIndicator extends StatelessWidget {
  final int pagesNum;
  final int selectedPageIndex;
  final PageController pageController;
  const AnimatedPageIndicator({
    super.key,
    required this.pagesNum,
    required this.selectedPageIndex,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List<Widget>.generate(
          pagesNum,
          (index) => GestureDetector(
            onTap: () {
              pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: index == selectedPageIndex ? 17.sp : 11.sp,
              height: index == selectedPageIndex ? 17.sp : 11.sp,
              margin: index != pagesNum - 1
                  ? EdgeInsets.only(right: 7.sp)
                  : null,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: index == selectedPageIndex
                    ? AppColors.primaryColor.withValues(alpha: .2)
                    : const Color(0xffF9B566),
              ),
              child: index == selectedPageIndex
                  ? Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        width: 11.sp,
                        height: 11.sp,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
