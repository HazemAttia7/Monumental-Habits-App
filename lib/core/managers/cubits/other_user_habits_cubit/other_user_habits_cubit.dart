import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pixel_true_app/features/home/data/models/habit_model.dart';
import 'package:pixel_true_app/features/home/data/repos/habits_repo.dart';

part 'other_user_habits_state.dart';

class OtherUserHabitsCubit extends Cubit<OtherUserHabitsState> {
  final HabitsRepo _repo;

  OtherUserHabitsCubit(this._repo) : super(OtherUserHabitsInitial());

  Future<void> fetchHabits(String userId) async {
    emit(OtherUserHabitsLoading());

    final result = await _repo.getHabitsByUserId(userId);

    result.fold(
      (failure) => emit(OtherUserHabitsError(failure.errMessage)),
      (habits) => emit(OtherUserHabitsLoaded(habits)),
    );
  }
}
