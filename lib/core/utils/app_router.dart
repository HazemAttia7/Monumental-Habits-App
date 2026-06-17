import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/app_gate.dart';
import 'package:pixel_true_app/core/helper/service_locator.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/features/about_us/presentation/views/about_us_view.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pixel_true_app/features/auth/presentation/views/auth_view.dart';
import 'package:pixel_true_app/features/auth/presentation/views/forgot_password_view.dart';
import 'package:pixel_true_app/features/community/data/models/post_model.dart';
import 'package:pixel_true_app/features/community/data/repos/comments_repo.dart';
import 'package:pixel_true_app/features/community/data/repos/likes_list_repo.dart';
import 'package:pixel_true_app/features/community/data/repos/posts_repo.dart';
import 'package:pixel_true_app/features/community/presentation/managers/comments_cubit/comments_cubit.dart';
import 'package:pixel_true_app/features/community/presentation/managers/community_view_controller.dart';
import 'package:pixel_true_app/features/community/presentation/managers/likes_list_cubit/likes_list_cubit.dart';
import 'package:pixel_true_app/features/community/presentation/managers/posts_cubit/posts_cubit.dart';
import 'package:pixel_true_app/features/community/presentation/views/community_view.dart';
import 'package:pixel_true_app/features/community/presentation/views/likes_list_view.dart';
import 'package:pixel_true_app/features/community/presentation/views/post_details_view.dart';
import 'package:pixel_true_app/features/courses/data/models/course_model.dart';
import 'package:pixel_true_app/features/courses/presentation/managers/course_details_view_controller.dart';
import 'package:pixel_true_app/features/courses/presentation/managers/courses_cubit/courses_cubit.dart';
import 'package:pixel_true_app/features/courses/presentation/views/course_details_view.dart';
import 'package:pixel_true_app/features/friends/data/repos/friends_repo.dart';
import 'package:pixel_true_app/features/friends/presentation/managers/friends_cubit/friends_cubit.dart';
import 'package:pixel_true_app/features/friends/presentation/managers/user_search_cubit/user_search_cubit.dart';
import 'package:pixel_true_app/features/friends/presentation/views/add_friend_view.dart';
import 'package:pixel_true_app/features/friends/presentation/views/friends_view.dart';
import 'package:pixel_true_app/features/habits_hsitory/presentation/managers/habits_history_view_controller.dart';
import 'package:pixel_true_app/features/habits_hsitory/presentation/views/habits_history_view.dart';
import 'package:pixel_true_app/features/home/data/models/habit_model.dart';
import 'package:pixel_true_app/core/managers/add_edit_habit_view_controller.dart';
import 'package:pixel_true_app/core/managers/cubits/habits_cubit/habits_cubit.dart';
import 'package:pixel_true_app/core/managers/habit_analysis_view_controller.dart';
import 'package:pixel_true_app/features/home/presentation/views/add_edit_habit_view.dart';
import 'package:pixel_true_app/features/home/presentation/views/habit_analysis_view.dart';
import 'package:pixel_true_app/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:pixel_true_app/features/profile/presentation/managers/profile_view_controller.dart';
import 'package:pixel_true_app/features/profile/presentation/views/profile_habits_analytics_view.dart';
import 'package:pixel_true_app/features/profile/presentation/views/profile_view.dart';
import 'package:pixel_true_app/features/splash/presentation/views/splash_view.dart';
import 'package:pixel_true_app/features/subscription/presentation/views/subscription_view.dart';
import 'package:pixel_true_app/features/support/presentation/managers/support_view_controller.dart';
import 'package:pixel_true_app/features/support/presentation/views/support_view.dart';
import 'package:provider/provider.dart';

// TODO : DONT PASS EVERY EXTRA OBJECT TO VIEW JUST READ IT IN BODY
abstract class AppRouter {
  static const String kOnboardingView = "/onboarding";
  static const String kAuthView = "/auth";
  static const String kCreateAccountView = "/create-account";
  static const String kForgotPasswordView = "/forgot-password";
  static const String kAppGate = "/app-gate";
  static const String kAddEditNewHabit = "/add-edit-new-habit";
  static const String kHabitAnalysis = "/habit-analysis";
  static const String kProfileView = "/profile";
  static const String kProfileHabitsAnalytics = "/profile-habits-analytics";
  static const String kHabitsHistory = "/habits-history";
  static const String kSupport = "/support";
  static const String kSubcrption = "/subscription";
  static const String kAboutUs = "/about-us";
  static const String kCourseDetailsView = "/course-details";
  static const String kPostDetailsView = "/post-details";
  static const String kLikesListView = "/likes";
  static const String kCommunityView = "/community";
  static const String kFriends = "/friends";
  static const String kAddFriend = "/add-friend";

  static final router = GoRouter(
    onException: (context, state, router) {
      final uri = state.uri;
      final segments = uri.pathSegments;
      if (segments.length == 3 &&
          segments[0] == 'monument-links' &&
          segments[1] == 'post') {
        final postId = segments[2];
        router.go('/post/$postId');
      } else {
        router.go('/');
      }
    },
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
        path: kAddEditNewHabit,
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>;
          final homeCubit = args["homeCubit"] as HabitsCubit;
          return BlocProvider.value(
            value: homeCubit,
            child: ChangeNotifierProvider(
              create: (_) => AddEditHabitViewController(habit: args["habit"]),
              child: AddEditHabitView(
                habitFormMode: args["mode"],
                backToHome: args["backToHome"],
                themeColor: args["themeColor"] as Color? ?? AppColors.morning,
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
          final Color themeColor =
              (args["themeColor"] as Color?) ?? AppColors.morning;
          final cubit = args["cubit"] as HabitsCubit;

          return BlocProvider.value(
            value: cubit,
            child: ChangeNotifierProvider(
              create: (_) => HabitAnalysisViewController(),
              child: HabitAnalysisView(habit: habit, themeColor: themeColor),
            ),
          );
        },
      ),
      GoRoute(
        path: kProfileView,
        builder: (context, state) {
          final cubit = state.extra as HabitsCubit;
          return BlocProvider.value(
            value: cubit,
            child: ChangeNotifierProvider<ProfileViewController>(
              create: (context) => ProfileViewController(),
              child: const ProfileView(),
            ),
          );
        },
      ),
      GoRoute(
        path: kProfileHabitsAnalytics,
        builder: (context, state) {
          final cubit = state.extra as HabitsCubit;
          return BlocProvider.value(
            value: cubit,
            child: ChangeNotifierProvider<ProfileViewController>(
              create: (context) => ProfileViewController(),
              child: const ProfileHabitsAnalyticsView(),
            ),
          );
        },
      ),
      GoRoute(
        path: kHabitsHistory,
        builder: (context, state) {
          final cubit = state.extra as HabitsCubit;
          return BlocProvider.value(
            value: cubit,
            child: ChangeNotifierProvider<HabitsHistoryController>(
              create: (_) => HabitsHistoryController(),
              child: const HabitsHistoryView(),
            ),
          );
        },
      ),
      GoRoute(
        path: kSupport,
        builder: (context, state) =>
            ChangeNotifierProvider<SupportViewController>(
              create: (_) => SupportViewController(),
              child: const SupportView(),
            ),
      ),
      GoRoute(
        path: kSubcrption,
        builder: (context, state) => const SubscriptionView(),
      ),
      GoRoute(path: kAboutUs, builder: (context, state) => const AboutUsView()),
      GoRoute(
        path: kCourseDetailsView,
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>;
          final course = args["course"] as Course;
          final cubit = args["cubit"] as CoursesCubit;
          final uid = context.read<AuthCubit>().currentUser!.uid;

          return BlocProvider.value(
            value: cubit,
            child: ChangeNotifierProvider(
              create: (_) =>
                  CourseDetailsViewController(courseId: course.id ?? "")
                    ..init(cubit, uid),
              child: CourseDetailsView(course: course),
            ),
          );
        },
      ),
      GoRoute(
        path: AppRouter.kCommunityView,
        builder: (context, state) {
          return BlocProvider(
            create: (_) => PostsCubit(sl<PostsRepo>())..watchPosts(),
            child: ChangeNotifierProvider(
              create: (_) => CommunityViewController(),
              child: const CommunityView(),
            ),
          );
        },
      ),
      GoRoute(
        path: kPostDetailsView,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final post = extra['post'] as Post;
          final scrollToComments = extra['scrollToComments'] as bool? ?? false;
          final cubit = extra['cubit'] as PostsCubit;

          return MultiBlocProvider(
            providers: [
              BlocProvider.value(value: cubit),
              BlocProvider(
                create: (context) =>
                    CommentsCubit(sl<CommentsRepo>())..watchComments(post.id),
              ),
              ChangeNotifierProvider(
                create: (context) => CommunityViewController(),
              ),
            ],
            child: PostDetailsView(scrollToComments: scrollToComments),
          );
        },
      ),
      GoRoute(
        path: '/post/:postId',
        builder: (context, state) {
          final postId = state.pathParameters['postId']!;

          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => PostsCubit(sl<PostsRepo>())..getPostById(postId),
              ),
              BlocProvider(
                create: (_) =>
                    CommentsCubit(sl<CommentsRepo>())..watchComments(postId),
              ),
              ChangeNotifierProvider(create: (_) => CommunityViewController()),
            ],
            child: const PostDetailsView(scrollToComments: false),
          );
        },
      ),
      GoRoute(
        path: kLikesListView,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => FriendsCubit(sl<FriendsRepo>())
                ..getPendingRequestIds()
                ..getFriends(),
            ),
            BlocProvider(
              create: (_) =>
                  LikesListCubit(sl<LikesListRepo>())
                    ..getLikesList(state.extra as List<String>),
            ),
          ],
          child: const LikesListView(),
        ),
      ),
      GoRoute(
        path: kFriends,
        builder: (context, state) => BlocProvider(
          create: (context) => FriendsCubit(sl<FriendsRepo>())
            ..getIncomingFriendRequests()
            ..getOutgoingFriendRequests()
            ..getFriends(),
          child: const FriendsView(),
        ),
      ),
      GoRoute(
        path: kAddFriend,
        builder: (context, state) {
          final cubit = state.extra as FriendsCubit;
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(value: cubit),
              BlocProvider(
                create: (context) => UserSearchCubit(sl<FriendsRepo>()),
              ),
            ],
            child: const AddFriendView(),
          );
        },
      ),
    ],
  );
}
