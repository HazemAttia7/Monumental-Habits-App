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
  })  : _local = local,
        _remote = remote,
        _connectivity = connectivity ?? Connectivity();

  // ── Public API ──────────────────────────────────────────────

  @override
  Future<Either<Failure, List<Habit>>> getHabits(String uid) async {
    try {
      final localHabits = await _local.getHabits(uid);

      if (await _isOnline()) {
        try {
          // Push first — if any push fails it throws and we skip the pull,
          // so we never wipe local data that hasn't reached Firestore yet.
          await _pushUnsyncedChanges(uid);
          await _pullFromFirestore(uid);
          return Right(await _local.getHabits(uid));
        } catch (_) {
          // Sync failed — degrade gracefully with local data, nothing wiped.
          return Right(localHabits);
        }
      }

      return Right(localHabits);
    } on Exception catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> addHabit(String uid, Habit habit) async {
    try {
      // Save locally first, mark unsynced
      await _local.saveHabit(habit, uid: uid, isSynced: false);

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
      // Soft delete locally — stays here until synced
      await _local.softDelete(habitId);

      if (await _isOnline()) {
        await _remote.deleteHabit(uid, habitId);
        await _local.hardDelete(habitId);
      }
      // If offline: _pushUnsyncedChanges will handle delete on next sync

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
    // Caller passes the already-updated habit so we never re-fetch
    // a potentially stale local record.
    Habit updatedHabit,
  ) async {
    try {
      // Save the full updated habit locally, mark unsynced
      await _local.saveHabit(updatedHabit, uid: uid, isSynced: false);

      if (await _isOnline()) {
        // Firestore dot-notation update for a single log field
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
      await _local.saveHabit(habit, uid: uid, isSynced: false);

      if (await _isOnline()) {
        await _remote.saveHabit(uid, habit);
        await _local.markSynced(habit.id);
      }

      return const Right(unit);
    } on Exception catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  /// Pushes unsynced local changes and pulls fresh data from Firestore.
/// Returns null if nothing changed, or the refreshed habit list on success.
@override
Future<Either<Failure, List<Habit>?>> syncPendingChanges(String uid) async {
  try {
    final unsynced = await _local.getUnsyncedHabits(uid);
    if (unsynced.isEmpty) return const Right(null); // nothing to do

    await _pushUnsyncedChanges(uid); // throws on failure
    await _pullFromFirestore(uid);
    return Right(await _local.getHabits(uid));
  } on Exception catch (e) {
    return Left(FirebaseFailure.fromException(e));
  }
}

  // ── Sync helpers ────────────────────────────────────────────

  /// Push all unsynced local changes to Firestore.
  /// Throws on any failure so the caller can skip the pull and
  /// avoid wiping local data that hasn't reached Firestore.
  Future<void> _pushUnsyncedChanges(String uid) async {
    final unsynced = await _local.getUnsyncedHabits(uid);
    for (final entity in unsynced) {
      if (entity.isDeleted) {
        await _remote.deleteHabit(uid, entity.habitId); // throws on failure
        await _local.hardDelete(entity.habitId);
      } else {
        await _remote.saveHabit(uid, entity.toDomain()); // throws on failure
        await _local.markSynced(entity.habitId);
      }
    }
  }

  /// Pull all habits from Firestore and replace local cache.
  /// Only called after _pushUnsyncedChanges succeeds — Firestore
  /// is source of truth when all local changes are confirmed synced.
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