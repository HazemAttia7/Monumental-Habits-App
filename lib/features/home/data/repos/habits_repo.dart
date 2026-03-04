import 'package:dartz/dartz.dart';
import 'package:pixel_true_app/core/enums/habit_comletion_state_enum.dart';
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
    enHabitCompletionState status,
  );
}