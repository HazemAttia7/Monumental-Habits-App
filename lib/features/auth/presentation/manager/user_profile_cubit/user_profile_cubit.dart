import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pixel_true_app/features/auth/data/repos/user_profile_repo.dart';
import 'package:pixel_true_app/models/user_profile_model.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  final UserProfileRepo _repo;

  UserProfileCubit(this._repo) : super(UserProfileInitial());

  Future<void> fetchProfile(String uid) async {
    emit(UserProfileLoading());
    final result = await _repo.getUserProfile(uid: uid);
    result.fold(
      (failure) => emit(UserProfileError(failure.errMessage)),
      (profile) => emit(UserProfileLoaded(profile)),
    );
  }

  void clear() => emit(UserProfileInitial());
}
