import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_router.dart';
import 'package:pixel_true_app/core/utils/assets_data.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MonumentalHabits());
}

class MonumentalHabits extends StatefulWidget {
  const MonumentalHabits({super.key});

  @override
  State<MonumentalHabits> createState() => _MonumentalHabitsState();
}

class _MonumentalHabitsState extends State<MonumentalHabits> {
  @override
  void initState() async {
    super.initState();
    await precacheImage(const AssetImage(AssetsData.splashBackground), context);
    await precacheImage(const AssetImage(AssetsData.loginBackground), context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterNativeSplash.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 866),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, widget) {
        return MaterialApp.router(
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
        );
      },
    );
  }
}
