import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/assets_data.dart';
import 'package:pixel_true_app/features/splash/presentation/views/widgets/fading_text.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late Animation<double> fadeAnimation;
  late AnimationController animationController;
  @override
  void initState() {
    super.initState();
    initFadeAnimation();
    navigateToOnboarding();
  }

  void navigateToOnboarding() {
    // Future.delayed(const Duration(seconds: 2), () {
    //   GoRouter.of(context).pushReplacement(AppRouter.kOnboardingView);
    // });
  }

  void initFadeAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(animationController);
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(AssetsData.splashBackground, fit: BoxFit.cover),
        ),
        Positioned(
          top: 96.h,
          left: 0,
          right: 0,
          child: Center(child: FadingText(fadeAnimation: fadeAnimation)),
        ),
      ],
    );
  }
}
