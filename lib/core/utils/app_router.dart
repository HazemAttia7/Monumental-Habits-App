import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/app_gate.dart';
import 'package:pixel_true_app/features/auth/presentation/views/auth_view.dart';
import 'package:pixel_true_app/features/auth/presentation/views/forgot_password_view.dart';
import 'package:pixel_true_app/features/home/data/models/habit_model.dart';
import 'package:pixel_true_app/features/home/presentation/managers/add_edit_habit_controller.dart';
import 'package:pixel_true_app/features/home/presentation/managers/cubits/home_cubit/home_cubit.dart';
import 'package:pixel_true_app/features/home/presentation/managers/habit_analysis_controller.dart';
import 'package:pixel_true_app/features/home/presentation/views/add_edit_habit_view.dart';
import 'package:pixel_true_app/features/home/presentation/views/habit_analysis_view.dart';
import 'package:pixel_true_app/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:pixel_true_app/features/splash/presentation/views/splash_view.dart';
import 'package:provider/provider.dart';

abstract class AppRouter {
  static const String kOnboardingView = "/onboarding";
  static const String kAuthView = "/auth";
  static const String kCreateAccountView = "/create-account";
  static const String kForgotPasswordView = "/forgot-password";
  static const String kAppGate = "/app-gate";
  static const String kAddNewHabit = "/add-new-habit";
  static const String kHabitAnalysis = "/habit-analysis";
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
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>;
          final homeCubit = args["homeCubit"] as HomeCubit;
          return BlocProvider.value(
            value: homeCubit,
            child: ChangeNotifierProvider(
              create: (_) => AddEditHabitController(habit: args["habit"]),
              child: AddEditHabitView(
                habitFormMode: args["mode"],
                backToHome: args["backToHome"],
                themeColor: args["themeColor"],
              ),
            ),
          );
        },
      ),
      GoRoute(
        path: kHabitAnalysis,
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>;

          final habit = args["habit"] as Habit;
          final themeColor = args["themeColor"] as Color;
          final cubit = args["cubit"] as HomeCubit;

          return BlocProvider.value(
            value: cubit,
            child: ChangeNotifierProvider(
              create: (_) => HabitAnalysisController(),
              child: HabitAnalysisView(habit: habit, themeColor: themeColor),
            ),
          );
        },
      ),
    ],
  );
}
