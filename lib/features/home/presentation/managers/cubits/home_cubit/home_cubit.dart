import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pixel_true_app/features/home/data/models/habit_model.dart';

part 'home_state.dart';

// TODO : implement OFA
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
}
