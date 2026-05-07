import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixel_true_app/core/helper/service_locator.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_router.dart';
import 'package:pixel_true_app/features/auth/data/repos/auth_repo_impl.dart';
import 'package:pixel_true_app/features/auth/data/repos/user_profile_repo.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/user_profile_cubit/user_profile_cubit.dart';

class MonumentalHabits extends StatefulWidget {
  const MonumentalHabits({super.key});

  @override
  State<MonumentalHabits> createState() => _MonumentalHabitsState();
}

class _MonumentalHabitsState extends State<MonumentalHabits> {
  final _appLinks = AppLinks();

  @override
  void initState() {
    super.initState();
    _handleIncomingLinks();
  }

  void _handleIncomingLinks() async {
    // Cold start — app was closed, user tapped the link
    final uri = await _appLinks.getInitialLink();
    if (uri != null) _handleLink(uri);

    // Warm start — app was in background, user tapped the link
    _appLinks.uriLinkStream.listen(_handleLink);
  }

  void _handleLink(Uri uri) {
    final segments = uri.pathSegments;
    // segments = ['monument-links', 'post', '123']
    if (segments.length == 3 &&
        segments[0] == 'monument-links' &&
        segments[1] == 'post') {
      final postId = segments[2];
      AppRouter.router.go('/post/$postId');
    }
  }

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
              create: (context) => UserProfileCubit(sl<UserProfileRepo>()),
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
