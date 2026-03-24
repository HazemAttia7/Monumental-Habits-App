import 'package:dartz/dartz.dart';
import 'package:pixel_true_app/core/enums/habit_enums.dart';
import 'package:pixel_true_app/core/errors/failure.dart';
import 'package:pixel_true_app/features/home/data/models/habit_model.dart';

abstract class HabitsRepo {
  Future<Either<Failure, List<Habit>>> getHabits(String uid);
  Future<Either<Failure, Unit>> addHabit(String uid, Habit habit);
  Future<Either<Failure, Unit>> deleteHabit(String uid, String habitId);
  Future<Either<Failure, Unit>> updateHabitLog(
    String uid,
    String habitId,
    String dateKey,
    enHabitDailyStatus status,
    // Caller passes the already-updated habit so we never re-fetch
    // a potentially stale local record.
    Habit updatedHabit,
  );
  Future<Either<Failure, Unit>> updateHabitStatus(
    String uid,
    String habitId,
    enHabitStatus status,
  );
  Future<Either<Failure, Unit>> updateHabit(String uid, Habit habit);
  Future<Either<Failure, List<Habit>?>> syncPendingChanges(String uid);
}
