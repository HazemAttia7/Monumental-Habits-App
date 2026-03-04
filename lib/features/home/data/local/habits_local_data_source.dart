import 'package:isar/isar.dart';
import 'package:pixel_true_app/features/home/data/local/habit_isar.dart';
import 'package:pixel_true_app/features/home/data/local/habit_isar_mapper.dart';
import 'package:pixel_true_app/features/home/data/models/habit_model.dart';

class HabitsLocalDataSource {
  final Isar _isar;
  HabitsLocalDataSource(this._isar);

  Future<List<Habit>> getHabits(String uid) async {
    final results = await _isar.habitIsars
        .filter()
        .uidEqualTo(uid)
        .isDeletedEqualTo(false)
        .findAll();
    return results.map((e) => e.toDomain()).toList();
  }

  Future<List<HabitIsar>> getUnsyncedHabits(String uid) async {
    return _isar.habitIsars
        .filter()
        .uidEqualTo(uid)
        .isSyncedEqualTo(false)
        .findAll();
  }

  Future<void> saveHabit(
    Habit habit, {
    required String uid,
    bool isSynced = false,
  }) async {
    await _isar.writeTxn(() async {
      await _isar.habitIsars.put(habit.toIsar(uid: uid, isSynced: isSynced));
    });
  }

  Future<void> saveHabits(
    List<Habit> habits, {
    required String uid,
    bool isSynced = true,
  }) async {
    await _isar.writeTxn(() async {
      await _isar.habitIsars.putAll(
        habits.map((h) => h.toIsar(uid: uid, isSynced: isSynced)).toList(),
      );
    });
  }

  Future<void> markSynced(String habitId) async {
    final entity = await _isar.habitIsars.get(fastHash(habitId));
    if (entity == null) return;
    await _isar.writeTxn(() async {
      entity.isSynced = true;
      await _isar.habitIsars.put(entity);
      entity.updatedAt = DateTime.now();
    });
  }

  Future<void> softDelete(String habitId) async {
    final entity = await _isar.habitIsars.get(fastHash(habitId));
    if (entity == null) return;
    await _isar.writeTxn(() async {
      entity.isDeleted = true;
      entity.isSynced = false;
      entity.updatedAt = DateTime.now();
      await _isar.habitIsars.put(entity);
    });
  }

  Future<void> clearAll(String uid) async {
    await _isar.writeTxn(() async {
      await _isar.habitIsars.filter().uidEqualTo(uid).deleteAll();
    });
  }

  Future<void> hardDelete(String habitId) async {
    await _isar.writeTxn(() async {
      await _isar.habitIsars.delete(fastHash(habitId));
    });
  }
}
