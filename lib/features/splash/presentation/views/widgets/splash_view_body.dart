import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pixel_true_app/core/utils/app_router.dart';
import 'package:pixel_true_app/core/utils/assets_data.dart';
import 'package:pixel_true_app/features/splash/presentation/views/widgets/fading_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    navigateToNextScreen();
  }

  Future<void> precacheImages() async {
    // Precache PNGs in parallel
    final pngFutures =
        [
          const AssetImage(AssetsData.loginBackground),
          const AssetImage(AssetsData.onboardingImage1),
          const AssetImage(AssetsData.onboardingImage2),
          const AssetImage(AssetsData.onboardingImage3),
          const AssetImage(AssetsData.onboardingImage4),
          const AssetImage(AssetsData.googleIcon),
          const AssetImage(AssetsData.facebookIcon),
          const AssetImage(AssetsData.quoteImage),
          const AssetImage(AssetsData.messagePopup),
          const AssetImage(AssetsData.teepeeSwirly),
          const AssetImage(AssetsData.appIcon),
          const AssetImage(AssetsData.coursesCard),
          const AssetImage(AssetsData.imagePlaceholder),
        ].map((provider) {
          final completer = Completer<void>();
          final stream = provider.resolve(ImageConfiguration.empty);
          stream.addListener(
            ImageStreamListener(
              (_, __) => completer.complete(),
              onError: (_, __) => completer.complete(),
            ),
          );
          return completer.future;
        });

    // Precache SVGs in parallel
    final svgFutures =
        [
          AssetsData.createYourAccountImage,
          AssetsData.forgotPasswordImage,
          AssetsData.homeBackgroundImage,
          AssetsData.community,
          AssetsData.courses,
          AssetsData.home,
          AssetsData.settings,
        ].map((path) async {
          try {
            final loader = SvgAssetLoader(path);
            await svg.cache.putIfAbsent(
              loader.cacheKey(null),
              () => loader.loadBytes(null),
            );
          } catch (_) {} // fail silently
        });

    await Future.wait([...pngFutures, ...svgFutures]);
  }

  void navigateToNextScreen() async {
    final prefs = await SharedPreferences.getInstance();
    final hasSeenOnboarding = prefs.getBool("seenOnboarding") ?? false;

    await Future.delayed(const Duration(seconds: 3));

    if (hasSeenOnboarding) {
      GoRouter.of(context).pushReplacement(AppRouter.kAppGate);
    } else {
      GoRouter.of(context).pushReplacement(AppRouter.kOnboardingView);
    }
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
