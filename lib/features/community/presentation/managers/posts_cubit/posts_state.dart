part of 'posts_cubit.dart';

sealed class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

final class PostsInitial extends PostsState {}


final class PostLoading extends PostsState {}

final class PostSuccess extends PostsState {
  final List<Post> posts;

  const PostSuccess(this.posts);

  @override
  List<Object> get props => [posts];
}

final class PostError extends PostsState {
  final String errMessage;
  const PostError(this.errMessage);

  @override
  List<Object> get props => [errMessage];
}