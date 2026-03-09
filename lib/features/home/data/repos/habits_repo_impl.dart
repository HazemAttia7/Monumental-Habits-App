import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:pixel_true_app/core/enums/habit_enums.dart';
import 'package:pixel_true_app/core/errors/failure.dart';
import 'package:pixel_true_app/features/home/data/local/habit_isar_mapper.dart';
import 'package:pixel_true_app/features/home/data/local/habits_local_data_source.dart';
import 'package:pixel_true_app/features/home/data/models/habit_model.dart';
import 'package:pixel_true_app/features/home/data/remote/habits_remote_data_source.dart';
import 'package:pixel_true_app/features/home/data/repos/habits_repo.dart';

class HabitsRepoImpl implements HabitsRepo {
  final HabitsLocalDataSource _local;
  final HabitsRemoteDataSource _remote;
  final Connectivity _connectivity;

  HabitsRepoImpl({
    required HabitsLocalDataSource local,
    required HabitsRemoteDataSource remote,
    Connectivity? connectivity,
  }) : _local = local,
       _remote = remote,
       _connectivity = connectivity ?? Connectivity();

  @override
  Future<Either<Failure, List<Habit>>> getHabits(String uid) async {
    try {
      // 1. Always return local data immediately — instant load
      final localHabits = await _local.getHabits(uid);

      // 2. If online: push unsynced changes up, pull fresh data down
      if (await _isOnline()) {
        await _pushUnsyncedChanges(uid);
        await _pullFromFirestore(uid);
        // Return refreshed local data after pull
        final refreshed = await _local.getHabits(uid);
        return Right(refreshed);
      }

      return Right(localHabits);
    } on Exception catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> addHabit(String uid, Habit habit) async {
    try {
      // 1. Save locally immediately — isSynced: false
      await _local.saveHabit(habit, uid: uid, isSynced: false);

      // 2. Try Firestore if online
      if (await _isOnline()) {
        await _remote.saveHabit(uid, habit);
        await _local.markSynced(habit.id);
      }

      return const Right(unit);
    } on Exception catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteHabit(String uid, String habitId) async {
    try {
      // 1. Soft delete locally first
      await _local.softDelete(habitId);

      // 2. If online, delete from Firestore then hard delete locally
      if (await _isOnline()) {
        await _remote.deleteHabit(uid, habitId);
        await _local.hardDelete(habitId); // ← just this one document
      }
      // If offline: stays soft deleted → _pushUnsyncedChanges will
      // delete it from Firestore next app open, then hard delete locally

      return const Right(unit);
    } on Exception catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateHabitLog(
    String uid,
    String habitId,
    String dateKey,
    enHabitDailyStatus status,
  ) async {
    try {
      // 1. Get current habit from local
      final habits = await _local.getHabits(uid);
      final habit = habits.firstWhere((h) => h.id == habitId);
      final updatedHabit = habit.copyWith(
        logs: Map.from(habit.logs)..[dateKey] = status,
      );

      // 2. Save updated habit locally — isSynced: false
      await _local.saveHabit(updatedHabit, uid: uid, isSynced: false);

      // 3. Try Firestore if online — use dot notation for single field update
      if (await _isOnline()) {
        await _remote.updateLog(uid, habitId, dateKey, status.name);
        await _local.markSynced(habitId);
      }

      return const Right(unit);
    } on Exception catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateHabitStatus(
    String uid,
    String habitId,
    enHabitStatus status,
  ) async {
    try {
      final habits = await _local.getHabits(uid);
      final habit = habits.firstWhere((h) => h.id == habitId);
      final updated = habit.copyWith(status: status);

      await _local.saveHabit(updated, uid: uid, isSynced: false);

      if (await _isOnline()) {
        await _remote.updateHabitStatus(uid, habitId, status);
        await _local.markSynced(habitId);
      }
      return const Right(unit);
    } on Exception catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateHabit(String uid, Habit habit) async {
    try {
      // Save locally first
      await _local.saveHabit(habit, uid: uid, isSynced: false);

      // Sync if online
      if (await _isOnline()) {
        await _remote.saveHabit(uid, habit);
        await _local.markSynced(habit.id);
      }

      return const Right(unit);
    } on Exception catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  // ── Sync helpers ────────────────────────────────────────────

  /// Push all local unsynced changes to Firestore
  Future<void> _pushUnsyncedChanges(String uid) async {
    final unsynced = await _local.getUnsyncedHabits(uid);
    for (final entity in unsynced) {
      try {
        if (entity.isDeleted) {
          await _remote.deleteHabit(uid, entity.habitId);
          await _local.hardDelete(entity.habitId); // ← clean up after sync
        } else {
          await _remote.saveHabit(uid, entity.toDomain());
          await _local.markSynced(entity.habitId);
        }
      } catch (_) {
        continue;
      }
    }
  }

  /// Pull all habits from Firestore and overwrite local cache
  /// Last write wins — Firestore is source of truth when online
  Future<void> _pullFromFirestore(String uid) async {
    final remoteHabits = await _remote.getHabits(uid);
    await _local.clearAll(uid);
    await _local.saveHabits(remoteHabits, uid: uid, isSynced: true);
  }

  Future<bool> _isOnline() async {
    final results = await _connectivity.checkConnectivity();
    return results.any((result) => result != ConnectivityResult.none);
  }
}
