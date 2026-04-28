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
  late final List<Comment> newestComments;
  late final List<Comment> oldestComments;
  late final List<Comment> mostLikedComments;
  final bool hasNewComments;
  CommentsSuccess(this.comments, {this.hasNewComments = false}) {
    newestComments = List.from(comments)
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    oldestComments = List.from(comments)
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
    mostLikedComments = List.from(comments)
      ..sort((a, b) => a.likedByUids.length.compareTo(b.likedByUids.length));
  }

  @override
  List<Object> get props => [comments, hasNewComments];
}

final class CommentsError extends CommentsState {
  final String errMessage;
  const CommentsError(this.errMessage);
  @override
  List<Object> get props => [errMessage];
}
