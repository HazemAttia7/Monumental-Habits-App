part of 'community_cubit.dart';

sealed class CommunityState extends Equatable {
  const CommunityState();

  @override
  List<Object> get props => [];
}

final class CommunityInitial extends CommunityState {}

final class CommunityLoading extends CommunityState {}

final class CommunityLoaded extends CommunityState {
  final List<Post> posts;

  const CommunityLoaded(this.posts);

  @override
  List<Object> get props => [posts];
}

final class CommunityError extends CommunityState {
  final String errMessage;
  final List<Post>? previousPosts;
  const CommunityError(this.errMessage, {this.previousPosts});

  @override
  List<Object> get props => [errMessage];
}
