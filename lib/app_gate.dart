import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pixel_true_app/features/auth/presentation/views/auth_view.dart';
import 'package:pixel_true_app/features/home/presentation/views/home_view.dart';
import 'package:pixel_true_app/features/splash/presentation/views/splash_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppGate extends StatelessWidget {
  const AppGate({super.key});

  Future<bool> _hasSeenOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('seenOnboarding') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _hasSeenOnboarding(),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.data == true) {
          return const SplashView();
        }
        return BlocConsumer<AuthCubit, AuthState>(
          buildWhen: (previous, current) => current is! AuthLoading,
          builder: (context, state) {
            if (state is Authenticated) {
              return const HomeView();
            } else if (state is Unauthenticated || state is AuthLoading) {
              return const AuthView();
            }

            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              ),
            );
          },
          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errMessage, style: AppStyles.textStyle14),
                ),
              );
            }
          },
        );
      },
    );
  }
}
