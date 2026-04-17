import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pixel_true_app/features/community/data/models/post_model.dart';
import 'package:pixel_true_app/features/community/data/services/posts_repo.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsRepo postRepo;
  PostsCubit(this.postRepo) : super(PostsInitial());

  Future<void> getPosts() async {
    emit(PostLoading());
    final result = await postRepo.getPosts();
    result.fold(
      (failure) => emit(PostError(failure.errMessage)),
      (posts) => emit(PostSuccess(posts)),
    );
  }

  Future<void> createPost(Post post) async {
    final currentState = state;
    if (currentState is! PostSuccess) return;

    final currentPosts = currentState.posts;
    emit(PostSuccess([...currentPosts, post]));

    final result = await postRepo.createPost(post);

    result.fold((failure) {
      emit(PostSuccess(currentPosts));
      emit(PostError(failure.errMessage));
    }, (_) => null);
  }

  Future<void> deletePost(Post post) async {
    final currentState = state;
    if (currentState is! PostSuccess) return;

    final currentPosts = currentState.posts;
    emit(PostSuccess(currentPosts.where((p) => p.id != post.id).toList()));

    final result = await postRepo.deletePost(post);

    result.fold((failure) {
      emit(PostSuccess(currentPosts));
      emit(PostError(failure.errMessage));
    }, (_) => null);
  }

  Future<void> toggleLike(String postId, String uid) async {
    final currentState = state;
    if (currentState is! PostSuccess) return;

    final currentPosts = currentState.posts;
    final index = currentPosts.indexWhere((p) => p.id == postId);
    if (index == -1) return;

    final post = currentPosts[index];

    final isLiked = post.likedByUids.contains(uid);

    final newLikedByUids = isLiked
        ? post.likedByUids.where((u) => u != uid).toList()
        : [...post.likedByUids, uid];

    final optimisticPosts = List<Post>.from(currentPosts);
    optimisticPosts[index] = post.copyWith(likedByUids: newLikedByUids);

    emit(PostSuccess(optimisticPosts));

    final result = isLiked
        ? await postRepo.unlikePost(postId, uid)
        : await postRepo.likePost(postId, uid);

    result.fold((failure) {
      emit(PostSuccess(currentPosts));
      emit(PostError(failure.errMessage));
    }, (_) => null);
  }
}
