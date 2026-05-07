part of 'likes_list_cubit.dart';

sealed class LikesListState extends Equatable {
  const LikesListState();

  @override
  List<Object> get props => [];
}

final class LikesListInitial extends LikesListState {}

class LikesListLoading extends LikesListState {}

class LikesListFailure extends LikesListState {
  final String message;

  const LikesListFailure(this.message);
}

class LikesListSuccess extends LikesListState {
  final List<UserProfile> users;

  const LikesListSuccess(this.users);
}
