import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_router.dart';
import 'package:pixel_true_app/core/utils/assets_data.dart';
import 'package:pixel_true_app/firebase_options.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MonumentalHabits());
}

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
