import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pixel_true_app/features/community/data/models/post_model.dart';
import 'package:pixel_true_app/features/community/data/repos/posts_repo.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsRepo postRepo;
  PostsCubit(this.postRepo) : super(PostsInitial());

  StreamSubscription? _subscription;

  void watchPosts() {
    emit(PostLoading());
    _subscription = postRepo.watchPosts().listen(
      (result) => result.fold(
        (failure) => emit(PostError(failure.errMessage)),
        (posts) => emit(PostSuccess(posts)),
      ),
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  Future<bool> createPost(Post post) async {
    final result = await postRepo.createPost(post);
    return result.fold((failure) {
      emit(PostError(failure.errMessage));
      return false;
    }, (_) => true);
  }

  Future<void> deletePost(Post post) async {
    final currentState = state;
    if (currentState is! PostSuccess) return;
    final result = await postRepo.deletePost(post);
    result.fold((failure) => emit(PostError(failure.errMessage)), (_) => null);
  }

  Future<void> toggleLike(String postId, String uid) async {
    final currentState = state;
    if (currentState is! PostSuccess) return;

    final currentPosts = currentState.posts;
    final index = currentPosts.indexWhere((p) => p.id == postId);
    if (index == -1) return;

    final post = currentPosts[index];
    final isLiked = post.likedByUids.contains(uid);

    // Keep optimistic update for snappy UI
    final optimisticPosts = List<Post>.from(currentPosts);
    optimisticPosts[index] = post.copyWith(
      likedByUids: isLiked
          ? post.likedByUids.where((u) => u != uid).toList()
          : [...post.likedByUids, uid],
    );
    emit(PostSuccess(optimisticPosts));

    final result = isLiked
        ? await postRepo.unlikePost(postId, uid)
        : await postRepo.likePost(postId, uid);

    result.fold((failure) => emit(PostError(failure.errMessage)), (_) => null);
  }
}
