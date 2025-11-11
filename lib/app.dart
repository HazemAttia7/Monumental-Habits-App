import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_router.dart';
import 'package:pixel_true_app/core/utils/assets_data.dart';
import 'package:pixel_true_app/features/auth/data/repos/auth_repo_impl.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';

class MonumentalHabits extends StatefulWidget {
  const MonumentalHabits({super.key});

  @override
  State<MonumentalHabits> createState() => _MonumentalHabitsState();
}

class _MonumentalHabitsState extends State<MonumentalHabits> {
  bool _imagesPrecached = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterNativeSplash.remove();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_imagesPrecached) {
      precacheImage(const AssetImage(AssetsData.splashBackground), context);
      precacheImage(const AssetImage(AssetsData.loginBackground), context);
      _imagesPrecached = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 866),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, widget) {
        return BlocProvider(
          create: (context) => AuthCubit(AuthRepoImpl())..checkAuth(),
          child: MaterialApp.router(
            routerConfig: AppRouter.router,
            title: 'Monumental Habits',
            theme: ThemeData.light().copyWith(
              scaffoldBackgroundColor: AppColors.scaffoldColor,
              textTheme: GoogleFonts.manropeTextTheme().apply(
                bodyColor: AppColors.primaryColor,
                displayColor: AppColors.primaryColor,
              ),
            ),
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}
