part of 'community_cubit.dart';

sealed class CommunityState extends Equatable {
  const CommunityState();

  @override
  List<Object> get props => [];
}

final class CommunityInitial extends CommunityState {}

final class CommunityLoading extends CommunityState {}

final class CommunitySuccess extends CommunityState {
  final List<Post> posts;

  const CommunitySuccess(this.posts);

  @override
  List<Object> get props => [posts];
}

final class CommunityError extends CommunityState {
  final String errMessage;
  const CommunityError(this.errMessage,);

  @override
  List<Object> get props => [errMessage];
}
