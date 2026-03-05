import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel_true_app/core/helper/service_locator.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/user_profile_cubit/user_profile_cubit.dart';
import 'package:pixel_true_app/features/auth/presentation/views/auth_view.dart';
import 'package:pixel_true_app/features/home/data/repos/habits_repo.dart';
import 'package:pixel_true_app/features/home/presentation/managers/cubits/home_cubit/home_cubit.dart';
import 'package:pixel_true_app/features/main/presentation/managers/main_view_controller.dart';
import 'package:pixel_true_app/features/main/presentation/views/main_view.dart';
import 'package:provider/provider.dart';

// TODO : wire home cubit here
class AppGate extends StatelessWidget {
  const AppGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      buildWhen: (previous, current) => current is! AuthLoading,
      builder: (context, state) {
        if (state is Authenticated) {
          return BlocProvider(
            create: (_) =>
                HomeCubit(sl<HabitsRepo>(), state.user.uid)..fetchHabits(),
            child: ChangeNotifierProvider(
              create: (_) => MainViewController(),
              child: const MainView(),
            ),
          );
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
        if (state is Authenticated) {
          context.read<UserProfileCubit>().fetchProfile(state.user.uid);
        } else if (state is Unauthenticated) {
          context.read<UserProfileCubit>().clear();
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMessage, style: AppStyles.textStyle14),
            ),
          );
        }
      },
    );
  }
}
