import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:pixel_true_app/core/services/isar_service.dart';
import 'package:pixel_true_app/features/home/data/local/habits_local_data_source.dart';
import 'package:pixel_true_app/features/home/data/remote/habits_remote_data_source.dart';
import 'package:pixel_true_app/features/home/data/repos/habits_repo.dart';
import 'package:pixel_true_app/features/home/data/repos/habits_repo_impl.dart';
import 'package:pixel_true_app/features/auth/data/repos/auth_repo.dart';
import 'package:pixel_true_app/features/auth/data/repos/auth_repo_impl.dart';
import 'package:pixel_true_app/features/auth/data/repos/user_profile_repo.dart';
import 'package:pixel_true_app/features/auth/data/repos/user_profile_repo_impl.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  sl.registerSingleton<Isar>(IsarService.instance);
  sl.registerSingleton<Connectivity>(Connectivity());

  sl.registerSingleton<HabitsLocalDataSource>(
    HabitsLocalDataSource(sl<Isar>()),
  );
  sl.registerSingleton<HabitsRemoteDataSource>(HabitsRemoteDataSource());

  // ── Repos ───────────────────────────────────────────────────
  sl.registerSingleton<AuthRepo>(AuthRepoImpl());
  sl.registerSingleton<UserProfileRepo>(UserProfileRepoImpl());
  sl.registerSingleton<HabitsRepo>(
    HabitsRepoImpl(
      local: sl<HabitsLocalDataSource>(),
      remote: sl<HabitsRemoteDataSource>(),
      connectivity: sl<Connectivity>(),
    ),
  );
}
