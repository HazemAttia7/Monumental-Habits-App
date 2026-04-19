import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pixel_true_app/features/community/data/models/reply_model.dart';
import 'package:pixel_true_app/features/community/data/repos/replies_repo.dart';

part 'replies_state.dart';

class RepliesCubit extends Cubit<RepliesState> {
  final RepliesRepo _repo;
  StreamSubscription? _repliesSub;

  RepliesCubit(this._repo) : super(RepliesInitial());

  void watchReplies(String postId, String commentId) {
    emit(RepliesLoading());
    bool isFirstLoad = true;

    _repliesSub = _repo
        .watchReplies(postId, commentId)
        .listen(
          (either) => either.fold(
            (failure) => emit(RepliesError(failure.errMessage)),
            (replies) {
              if (isFirstLoad) {
                isFirstLoad = false;
                emit(RepliesSuccess(replies));
              } else {
                emit(RepliesSuccess(replies, hasNewReplies: true));
              }
            },
          ),
          onError: (e) => emit(RepliesError(e.toString())),
        );
  }

  void dismissNewReplies() {
    final current = state;
    if (current is RepliesSuccess) {
      emit(RepliesSuccess(current.replies, hasNewReplies: false));
    }
  }

  @override
  Future<void> close() {
    _repliesSub?.cancel();
    return super.close();
  }
}
