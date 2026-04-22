import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:pixel_true_app/core/services/isar_service.dart';
import 'package:pixel_true_app/core/services/notification_service.dart';
import 'package:pixel_true_app/features/community/data/repos/comments_repo.dart';
import 'package:pixel_true_app/features/community/data/repos/comments_repo_impl.dart';
import 'package:pixel_true_app/features/community/data/repos/posts_repo.dart';
import 'package:pixel_true_app/features/community/data/repos/posts_repo_impl.dart';
import 'package:pixel_true_app/features/community/data/repos/replies_repo.dart';
import 'package:pixel_true_app/features/community/data/repos/replies_repo_impl.dart';
import 'package:pixel_true_app/features/community/presentation/managers/comments_cubit/comments_cubit.dart';
import 'package:pixel_true_app/features/courses/data/repos/courses_repo.dart';
import 'package:pixel_true_app/features/courses/data/repos/courses_repo_impl.dart';
import 'package:pixel_true_app/features/home/data/local/habits_local_data_source.dart';
import 'package:pixel_true_app/features/home/data/remote/habits_remote_data_source.dart';
import 'package:pixel_true_app/features/home/data/repos/habits_repo.dart';
import 'package:pixel_true_app/features/home/data/repos/habits_repo_impl.dart';
import 'package:pixel_true_app/features/auth/data/repos/auth_repo.dart';
import 'package:pixel_true_app/features/auth/data/repos/auth_repo_impl.dart';
import 'package:pixel_true_app/features/auth/data/repos/user_profile_repo.dart';
import 'package:pixel_true_app/features/auth/data/repos/user_profile_repo_impl.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator({
  required NotificationService notificationService,
}) async {
  sl.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  sl.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);

  // ── Services ───────────────────────────────────────────────
  sl.registerSingleton<Isar>(IsarService.instance);
  sl.registerSingleton<Connectivity>(Connectivity());
  sl.registerSingleton<NotificationService>(notificationService);

  sl.registerSingleton<HabitsLocalDataSource>(
    HabitsLocalDataSource(sl<Isar>()),
  );
  sl.registerSingleton<HabitsRemoteDataSource>(
    HabitsRemoteDataSource(firestore: sl<FirebaseFirestore>()),
  );

  // ── Repos ───────────────────────────────────────────────────
  sl.registerSingleton<AuthRepo>(
    AuthRepoImpl(auth: sl<FirebaseAuth>(), firestore: sl<FirebaseFirestore>()),
  );
  sl.registerSingleton<UserProfileRepo>(
    UserProfileRepoImpl(firestore: sl<FirebaseFirestore>()),
  );
  sl.registerSingleton<HabitsRepo>(
    HabitsRepoImpl(
      local: sl<HabitsLocalDataSource>(),
      remote: sl<HabitsRemoteDataSource>(),
      connectivity: sl<Connectivity>(),
    ),
  );
  sl.registerSingleton<CoursesRepo>(
    CoursesRepoImpl(firestore: sl<FirebaseFirestore>()),
  );
  sl.registerSingleton<PostsRepo>(
    PostsRepoImpl(firestore: sl<FirebaseFirestore>()),
  );
  sl.registerSingleton<CommentsRepo>(
    CommentsRepoImpl(firestore: sl<FirebaseFirestore>()),
  );

  sl.registerSingleton<RepliesRepo>(
    RepliesRepoImpl(firestore: sl<FirebaseFirestore>()),
  );

  // ──── Cubits ───────────────────────────────────────────────
  sl.registerFactory(() => CommentsCubit(sl<CommentsRepo>()));
}
