part of 'friends_cubit.dart';

sealed class FriendsState extends Equatable {
  const FriendsState();

  @override
  List<Object> get props => [];
}

class FriendsInitial extends FriendsState {}

// Send Request
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

// Cancel Request
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

// Pending Ids
class PendingIdsLoaded extends FriendsState {
  final List<String> pendingIds;
  const PendingIdsLoaded(this.pendingIds);

  @override
  List<Object> get props => [pendingIds];
}

// Friends and Requests
class FriendsViewLoaded extends FriendsState {
  final List<FriendRequest> requests;
  final List<Friend> friends;
  const FriendsViewLoaded({required this.requests, required this.friends});

  @override
  List<Object> get props => [requests, friends];
}

class FriendRequestsFailure extends FriendsState {
  final String errMessage;
  const FriendRequestsFailure(this.errMessage);

  @override
  List<Object> get props => [errMessage];
}

class FriendsFailure extends FriendsState {
  final String errMessage;
  const FriendsFailure(this.errMessage);

  @override
  List<Object> get props => [errMessage];
}

// Accept Request
class AcceptFriendRequestLoading extends FriendsState {
  final String senderId;

  const AcceptFriendRequestLoading({required this.senderId});

  @override
  List<Object> get props => [senderId];
}

class AcceptFriendRequestSuccess extends FriendsState {
  final String senderId;

  const AcceptFriendRequestSuccess({required this.senderId});

  @override
  List<Object> get props => [senderId];
}

class AcceptFriendRequestFailure extends FriendsState {
  final String errMessage;
  final String senderId;

  const AcceptFriendRequestFailure(this.errMessage, {required this.senderId});

  @override
  List<Object> get props => [errMessage, senderId];
}

// Decline Request
class DeclineFriendRequestLoading extends FriendsState {
  final String senderId;

  const DeclineFriendRequestLoading({required this.senderId});

  @override
  List<Object> get props => [senderId];
}

class DeclineFriendRequestSuccess extends FriendsState {
  final String senderId;

  const DeclineFriendRequestSuccess({required this.senderId});

  @override
  List<Object> get props => [senderId];
}

class DeclineFriendRequestFailure extends FriendsState {
  final String errMessage;
  final String senderId;

  const DeclineFriendRequestFailure(this.errMessage, {required this.senderId});

  @override
  List<Object> get props => [errMessage, senderId];
}
