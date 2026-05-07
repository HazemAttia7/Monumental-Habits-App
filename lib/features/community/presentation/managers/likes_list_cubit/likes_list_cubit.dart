import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pixel_true_app/features/community/data/repos/likes_list_repo.dart';
import 'package:pixel_true_app/models/user_profile_model.dart';

part 'likes_list_state.dart';

class LikesListCubit extends Cubit<LikesListState> {
  final LikesListRepo repo;

  LikesListCubit(this.repo) : super(LikesListInitial());

  Future<void> getLikesList(List<String> uids) async {
    emit(LikesListLoading());

    final result = await repo.getLikesListByUids(uids);

    result.fold(
      (failure) => emit(LikesListFailure(failure.errMessage)),
      (users) => emit(LikesListSuccess(users)),
    );
  }
}
