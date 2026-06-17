part of 'user_search_cubit.dart';

sealed class UserSearchState extends Equatable {
  const UserSearchState();

  @override
  List<Object> get props => [];
}

final class UserSearchInitial extends UserSearchState {}

// User Search
class UserSearchLoading extends UserSearchState {}

class UserSearchResults extends UserSearchState {
  final List<UserProfile> users;
  const UserSearchResults(this.users);

  @override
  List<Object> get props => [users];
}

class UserSearchFailure extends UserSearchState {
  final String message;
  const UserSearchFailure(this.message);

  @override
  List<Object> get props => [message];
}
