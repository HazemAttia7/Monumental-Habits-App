import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pixel_true_app/features/community/data/models/comment_model.dart';
import 'package:pixel_true_app/features/community/data/repos/comments_repo.dart';

part 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  final CommentsRepo _repo;
  StreamSubscription? _commentsSub;

  CommentsCubit(this._repo) : super(CommentsInitial());

  void watchComments(String postId) {
    emit(CommentsLoading());

    _commentsSub = _repo
        .watchComments(postId)
        .listen(
          (either) => either.fold(
            (failure) => emit(CommentsError(failure.errMessage)),
            (comments) => emit(CommentsSuccess(comments)),
          ),
        );
  }

  @override
  Future<void> close() {
    _commentsSub?.cancel();
    return super.close();
  }
}
