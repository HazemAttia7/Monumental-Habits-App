import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/app_gate.dart';
import 'package:pixel_true_app/features/auth/presentation/views/auth_view.dart';
import 'package:pixel_true_app/features/auth/presentation/views/forgot_password_view.dart';
import 'package:pixel_true_app/features/home/presentation/views/add_new_habit.dart';
import 'package:pixel_true_app/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:pixel_true_app/features/splash/presentation/views/splash_view.dart';

abstract class AppRouter {
  static const String kOnboardingView = "/onboarding";
  static const String kAuthView = "/auth";
  static const String kCreateAccountView = "/create-account";
  static const String kForgotPasswordView = "/forgot-password";
  static const String kAppGate = "/app-gate";
  static const String kAddNewHabit = "/add-new-habit";
  static final router = GoRouter(
    routes: [
      GoRoute(path: "/", builder: (context, state) => const SplashView()),
      GoRoute(path: kAppGate, builder: (context, state) => const AppGate()),
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
      GoRoute(path: kAuthView, builder: (context, state) => const AuthView()),
      GoRoute(
        path: kForgotPasswordView,
        builder: (context, state) => const ForgotPasswordView(),
      ),
      GoRoute(
        path: kAddNewHabit,
        builder: (context, state) => const AddNewHabit(),
      ),
    ],
  );
}
