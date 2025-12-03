import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pixel_true_app/core/utils/app_router.dart';
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
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImages();
    });
    initFadeAnimation();
    navigateToAppGate();
  }

  void precacheImages() async {
    await precacheImage(const AssetImage(AssetsData.splashBackground), context);
    await precacheImage(const AssetImage(AssetsData.loginBackground), context);
    await precacheImage(const AssetImage(AssetsData.onboardingImage1), context);
    await precacheImage(const AssetImage(AssetsData.onboardingImage2), context);
    await precacheImage(const AssetImage(AssetsData.onboardingImage3), context);
    await precacheImage(const AssetImage(AssetsData.onboardingImage4), context);
  }

  void navigateToAppGate() {
    Future.delayed(const Duration(seconds: 5), () {
      GoRouter.of(context).pushReplacement(AppRouter.kAppGate);
    });
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
    animationController.repeat(reverse: true);
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
        Positioned(
          bottom: 20.h,
          left: 0,
          right: 0,
          child: Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: Colors.white,
              size: 40.sp,
            ),
          ),
        ),
      ],
    );
  }
}
