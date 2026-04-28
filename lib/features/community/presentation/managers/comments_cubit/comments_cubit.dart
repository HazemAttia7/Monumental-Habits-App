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
    result.fold((failure) => emit(CommentsError(failure.errMessage)), (_) {});
  }

  Future<void> toggleCommentLike(Comment comment, String uid) async {
    if (state is! CommentsSuccess) return;
    final comments = (state as CommentsSuccess).comments;
    final isLiked = comment.isLikedBy(uid);

    // Optimistic update
    final updatedComment = comment.copyWith(
      likedByUids: isLiked
          ? (List.from(comment.likedByUids)..remove(uid))
          : (List.from(comment.likedByUids)..add(uid)),
    );
    emit(
      CommentsSuccess(
        comments.map((c) => c.id == comment.id ? updatedComment : c).toList(),
      ),
    );

    // Firestore write
    final result = isLiked
        ? await _repo.unlikeComment(comment.postId, comment.id, uid)
        : await _repo.likeComment(comment.postId, comment.id, uid);

    // Roll back on failure
    result.fold(
      (_) => emit(
        CommentsSuccess(
          comments.map((c) => c.id == comment.id ? comment : c).toList(),
        ),
      ),
      (_) {},
    );
  }

  @override
  Future<void> close() {
    _commentsSub?.cancel();
    return super.close();
  }
}
