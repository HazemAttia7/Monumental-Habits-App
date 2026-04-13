import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pixel_true_app/features/community/data/models/post_model.dart';
import 'package:pixel_true_app/features/community/data/services/post_repo.dart';

part 'community_state.dart';

class CommunityCubit extends Cubit<CommunityState> {
  PostRepo postRepo;
  CommunityCubit(this.postRepo) : super(CommunityInitial());

  Future<void> getPosts() async {
    emit(CommunityLoading());
    final result = await postRepo.getPosts();
    result.fold(
      (failure) => emit(CommunityError(failure.errMessage)),
      (posts) => emit(CommunitySuccess(posts)),
    );
  }

  Future<void> createPost(Post post) async {
    final currentState = state;
    if (currentState is! CommunitySuccess) return;

    final currentPosts = currentState.posts;
    emit(CommunitySuccess([...currentPosts, post]));

    final result = await postRepo.createPost(post);

    result.fold((failure) {
      emit(CommunitySuccess(currentPosts));
      emit(CommunityError(failure.errMessage));
    }, (_) => null);
  }

  Future<void> deletePost(Post post) async {
    final currentState = state;
    if (currentState is! CommunitySuccess) return;

    final currentPosts = currentState.posts;
    emit(CommunitySuccess(currentPosts.where((p) => p.id != post.id).toList()));

    final result = await postRepo.deletePost(post);
    
    result.fold((failure) {
      emit(CommunitySuccess(currentPosts));
      emit(CommunityError(failure.errMessage));
    }, (_) => null);
  }

  Future<void> toggleLike(String postId, String uid) async {
    final currentState = state;
    if (currentState is! CommunitySuccess) return;

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

    emit(CommunitySuccess(optimisticPosts));

    final result = isLiked
        ? await postRepo.unlikePost(postId, uid)
        : await postRepo.likePost(postId, uid);

    result.fold((failure) {
      emit(CommunitySuccess(currentPosts));
      emit(CommunityError(failure.errMessage));
    }, (_) => null);
  }
}
