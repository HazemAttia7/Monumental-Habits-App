import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/features/splash/presentation/views/splash_view.dart';

abstract class AppRouter {
  static const String kOnboardingView = "/onboarding";
  static final router = GoRouter(
    routes: [
      GoRoute(path: "/", builder: (context, state) => const SplashView()),
      // GoRoute(
      //   path: kOnboardingView,
      //   builder: (context, state) => const OnboardingView(),
      // ),
    ],
  );
}
