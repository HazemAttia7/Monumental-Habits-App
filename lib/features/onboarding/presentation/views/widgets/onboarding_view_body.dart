import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/core/utils/app_router.dart';
import 'package:pixel_true_app/core/utils/assets_data.dart';
import 'package:pixel_true_app/core/utils/constants.dart';
import 'package:pixel_true_app/core/widgets/custom_button.dart';
import 'package:pixel_true_app/features/onboarding/presentation/views/widgets/onboarding_controls.dart';
import 'package:pixel_true_app/features/onboarding/presentation/views/widgets/onboarding_page.dart';
import 'package:pixel_true_app/features/onboarding/presentation/views/widgets/onboarding_subtitle.dart';

class OnboardingViewBody extends StatefulWidget {
  const OnboardingViewBody({super.key});

  @override
  State<OnboardingViewBody> createState() => _OnboardingViewBodyState();
}

class _OnboardingViewBodyState extends State<OnboardingViewBody> {
  PageController pageController = PageController();
  int currentPageIndex = 0;
  final List<Widget> pages = const [
    OnboardingPage(
      title: "WELCOME TO Monumental habits",
      image: AssetsData.onboardingImage1,
    ),
    OnboardingPage(
      title: "CREATE NEW HABIT EASILY",
      image: AssetsData.onboardingImage2,
    ),
    OnboardingPage(
      title: "KEEP TRACK OF YOUR PROGRESS",
      image: AssetsData.onboardingImage3,
    ),
    OnboardingPage(
      title: "JOIN A SUPPORTIVE COMMUNITY",
      image: AssetsData.onboardingImage4,
    ),
  ];

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 619.h,
              child: PageView(
                controller: pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentPageIndex = index;
                  });
                },
                children: pages,
              ),
            ),
            Gap(15.h),
            const OnboardingSubtitle(),
            const Spacer(),
            Column(
              children: [
                (currentPageIndex != pages.length - 1)
                    ? OnboardingControls(
                        pageController: pageController,
                        pagesNum: pages.length,
                        selectedPageIndex: currentPageIndex,
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: kPagePadding.w,
                        ),
                        child: CustomButton(
                          text: 'Get Started',
                          onTap: () {
                            GoRouter.of(
                              context,
                            ).pushReplacement(AppRouter.kLoginView);
                          },
                        ),
                      ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
