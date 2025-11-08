import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/features/auth/presentation/views/create_account_view.dart';
import 'package:pixel_true_app/features/auth/presentation/views/login_view.dart';
import 'package:pixel_true_app/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:pixel_true_app/features/splash/presentation/views/splash_view.dart';

abstract class AppRouter {
  static const String kOnboardingView = "/onboarding";
  static const String kLoginView = "/login";
  static const String kCreateAccountView = "/create-account";
  static final router = GoRouter(
    routes: [
      GoRoute(path: "/", builder: (context, state) => const SplashView()),
      GoRoute(
        path: kOnboardingView,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const OnboardingView(),
          transitionDuration: const Duration(milliseconds: 700),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(
              begin: begin,
              end: end,
            ).chain(CurveTween(curve: Curves.easeInOut));
            final offsetAnimation = animation.drive(tween);

            return SlideTransition(position: offsetAnimation, child: child);
          },
        ),
      ),
      GoRoute(path: kLoginView, builder: (context, state) => const LoginView()),
      GoRoute(path: kCreateAccountView, builder: (context, state) => const CreateAccountView()),
    ],
  );
}
