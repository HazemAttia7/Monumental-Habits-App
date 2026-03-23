import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_router.dart';
import 'package:pixel_true_app/features/auth/data/repos/auth_repo_impl.dart';
import 'package:pixel_true_app/features/auth/data/repos/user_profile_repo_impl.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/user_profile_cubit/user_profile_cubit.dart';

class MonumentalHabits extends StatelessWidget {
  const MonumentalHabits({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.42857142857144, 832.7619047619048),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, widget) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => AuthCubit(AuthRepoImpl())..checkAuth()),
            BlocProvider(
              create: (context) => UserProfileCubit(UserProfileRepoImpl()),
            ),
          ],
          child: MaterialApp.router(
            routerConfig: AppRouter.router,
            title: 'Monumental Habits',
            theme: ThemeData.light().copyWith(
              scaffoldBackgroundColor: AppColors.scaffoldColor,
              textTheme: GoogleFonts.manropeTextTheme().apply(
                bodyColor: AppColors.secondaryColor,
                displayColor: AppColors.secondaryColor,
              ),
            ),
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}
