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

  Future<void> addReply(Reply reply) async {
    final result = await _repo.addReply(reply);
    result.fold((failure) => emit(RepliesError(failure.errMessage)), (_) {});
  }

  Future<void> toggleReplyLike(Reply reply, String uid) async {
    if (state is! RepliesSuccess) return;
    final replies = (state as RepliesSuccess).replies;
    final isLiked = reply.isLikedBy(uid);

    // Optimistic update
    final updatedReply = reply.copyWith(
      likedByUids: isLiked
          ? (List.from(reply.likedByUids)..remove(uid))
          : (List.from(reply.likedByUids)..add(uid)),
    );
    emit(
      RepliesSuccess(
        replies.map((r) => r.id == reply.id ? updatedReply : r).toList(),
      ),
    );

    // Firestore write
    final result = isLiked
        ? await _repo.unlikeReply(reply.postId, reply.commentId, reply.id, uid)
        : await _repo.likeReply(reply.postId, reply.commentId, reply.id, uid);

    // Roll back on failure
    result.fold(
      (_) => emit(
        RepliesSuccess(
          replies.map((r) => r.id == reply.id ? reply : r).toList(),
        ),
      ),
      (_) {},
    );
  }

String generateReplyId(String postId, String commentId) {
  return _repo.generateReplyId(postId, commentId);
}

  @override
  Future<void> close() {
    _repliesSub?.cancel();
    return super.close();
  }
}
