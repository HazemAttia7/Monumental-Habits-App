part of 'comments_cubit.dart';

sealed class CommentsState extends Equatable {
  const CommentsState();

  @override
  List<Object> get props => [];
}

final class CommentsInitial extends CommentsState {}

final class CommentsLoading extends CommentsState {}

final class CommentsSuccess extends CommentsState {
  final List<Comment> comments;
  const CommentsSuccess(this.comments);
  @override
  List<Object> get props => [comments];
}

final class CommentsError extends CommentsState {
  final String errMessage;
  const CommentsError(this.errMessage);
  @override
  List<Object> get props => [errMessage];
}
