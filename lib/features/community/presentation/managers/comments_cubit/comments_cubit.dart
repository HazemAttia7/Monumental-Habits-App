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
    bool isFirstLoad = true;

    _commentsSub = _repo
        .watchComments(postId)
        .listen(
          (either) => either.fold(
            (failure) => emit(CommentsError(failure.errMessage)),
            (comments) {
              if (isFirstLoad) {
                isFirstLoad = false;
                emit(CommentsSuccess(comments));
              } else {
                emit(CommentsSuccess(comments, hasNewComments: true));
              }
            },
          ),
        );
  }

    Future<void> addComment(Comment comment) async {
    final result = await _repo.addComment(comment);
    result.fold(
      (failure) => emit(CommentsError(failure.errMessage)),
      (_) {},
    );
  }

  @override
  Future<void> close() {
    _commentsSub?.cancel();
    return super.close();
  }
}
