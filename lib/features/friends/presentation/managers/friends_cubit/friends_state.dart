part of 'friends_cubit.dart';

sealed class FriendsState extends Equatable {
  const FriendsState();

  @override
  List<Object> get props => [];
}

class FriendsInitial extends FriendsState {}

class SendFriendRequestLoading extends FriendsState {
  final String receiverId;
  const SendFriendRequestLoading({required this.receiverId});

  @override
  List<Object> get props => [receiverId];
}

class SendFriendRequestSuccess extends FriendsState {
  final String receiverId;
  const SendFriendRequestSuccess({required this.receiverId});

  @override
  List<Object> get props => [receiverId];
}

class SendFriendRequestFailure extends FriendsState {
  final String errMessage;
  final String receiverId;
  const SendFriendRequestFailure(this.errMessage, {required this.receiverId});

  @override
  List<Object> get props => [errMessage, receiverId];
}

class PendingIdsLoaded extends FriendsState {
  final List<String> pendingIds;
  const PendingIdsLoaded(this.pendingIds);

  @override
  List<Object> get props => [pendingIds];
}

class CancelFriendRequestLoading extends FriendsState {
  final String receiverId;
  const CancelFriendRequestLoading({required this.receiverId});

  @override
  List<Object> get props => [receiverId];
}

class CancelFriendRequestSuccess extends FriendsState {
  final String receiverId;
  const CancelFriendRequestSuccess({required this.receiverId});

  @override
  List<Object> get props => [receiverId];
}

class CancelFriendRequestFailure extends FriendsState {
  final String errMessage;
  final String receiverId;
  const CancelFriendRequestFailure(this.errMessage, {required this.receiverId});

  @override
  List<Object> get props => [errMessage, receiverId];
}
