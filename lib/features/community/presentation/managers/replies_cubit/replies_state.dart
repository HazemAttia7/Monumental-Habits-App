part of 'replies_cubit.dart';

sealed class RepliesState extends Equatable {
  const RepliesState();

  @override
  List<Object> get props => [];
}

final class RepliesInitial extends RepliesState {}

final class RepliesLoading extends RepliesState {}

final class RepliesSuccess extends RepliesState {
  final List<Reply> replies;
  final bool hasNewReplies;
  const RepliesSuccess(this.replies, {this.hasNewReplies = false});

  @override
  List<Object> get props => [replies, hasNewReplies];
}

final class RepliesError extends RepliesState {
  final String errMessage;
  const RepliesError(this.errMessage);

  @override
  List<Object> get props => [errMessage];
}
