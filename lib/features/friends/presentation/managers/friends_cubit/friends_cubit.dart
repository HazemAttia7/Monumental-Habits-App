import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pixel_true_app/features/friends/data/models/friend_model.dart';
import 'package:pixel_true_app/features/friends/data/models/friend_request_model.dart';
import 'package:pixel_true_app/features/friends/data/repos/friends_repo.dart';

part 'friends_state.dart';

class FriendsCubit extends Cubit<FriendsState> {
  final FriendsRepo _friendsRepo;
  FriendsCubit(this._friendsRepo) : super(FriendsInitial());

  List<String> pendingIds = [];
  bool isFriend(String uid) => _friends.any((friend) => friend.uid == uid);

  bool hasReceivedRequest(String uid) {
    return _receivedRequests.any((request) => request.userId == uid);
  }

  bool hasSentRequest(String uid) {
    return _sentRequests.any((request) => request.userId == uid);
  }

  FriendRequest? getReceivedRequest(String uid) {
    try {
      return _receivedRequests.firstWhere((request) => request.userId == uid);
    } catch (_) {
      return null;
    }
  }

  FriendRequest? getSentRequest(String uid) {
    try {
      return _sentRequests.firstWhere((request) => request.userId == uid);
    } catch (_) {
      return null;
    }
  }

  List<FriendRequest> _sentRequests = [];
  List<FriendRequest> _receivedRequests = [];
  List<Friend> _friends = [];

  bool _sentSettled = false;
  bool _receivedSettled = false;
  bool _friendsSettled = false;

  String? _sentError;
  String? _receivedError;
  String? _friendsError;

  StreamSubscription? _sentRequestsSub;
  StreamSubscription? _receivedRequestsSub;
  StreamSubscription? _friendsSub;

  void _emitIfAllSettled() {
    if (!_sentSettled || !_receivedSettled || !_friendsSettled) return;

    final error = _sentError ?? _receivedError ?? _friendsError;
    if (error != null) {
      emit(FriendsFailure(error));
      return;
    }

    emit(
      FriendsViewLoaded(
        sentRequests: _sentRequests,
        receivedRequests: _receivedRequests,
        friends: _friends,
      ),
    );
  }

  void getOutgoingFriendRequests() {
    _sentRequestsSub?.cancel();
    _sentRequestsSub = _friendsRepo.getOutgoingFriendRequests().listen((
      result,
    ) {
      result.fold(
        (failure) {
          _sentError = failure.errMessage;
          _sentSettled = true;
          _emitIfAllSettled();
        },
        (requests) {
          _sentRequests = requests;
          _sentError = null;
          _sentSettled = true;
          _emitIfAllSettled();
        },
      );
    });
  }

  void getIncomingFriendRequests() {
    _receivedRequestsSub?.cancel();
    _receivedRequestsSub = _friendsRepo.getIncomingFriendRequests().listen((
      result,
    ) {
      result.fold(
        (failure) {
          _receivedError = failure.errMessage;
          _receivedSettled = true;
          _emitIfAllSettled();
        },
        (requests) {
          _receivedRequests = requests;
          _receivedError = null;
          _receivedSettled = true;
          _emitIfAllSettled();
        },
      );
    });
  }

  void getFriends() {
    _friendsSub?.cancel();
    _friendsSub = _friendsRepo.getFriends().listen((result) {
      result.fold(
        (failure) {
          _friendsError = failure.errMessage;
          _friendsSettled = true;
          _emitIfAllSettled();
        },
        (friends) {
          _friends = friends;
          _friendsError = null;
          _friendsSettled = true;
          _emitIfAllSettled();
        },
      );
    });
  }

  Future<void> sendFriendRequest({
    required String receiverId,
    required String receiverUsername,
  }) async {
    emit(SendFriendRequestLoading(receiverId: receiverId));

    final result = await _friendsRepo.sendFriendRequest(
      receiverId: receiverId,
      receiverUsername: receiverUsername,
    );

    result.fold(
      (failure) => emit(
        SendFriendRequestFailure(failure.errMessage, receiverId: receiverId),
      ),
      (_) {
        pendingIds.add(receiverId);
        emit(SendFriendRequestSuccess(receiverId: receiverId));
      },
    );
  }

  Future<void> cancelFriendRequest({required String receiverId}) async {
    emit(CancelFriendRequestLoading(receiverId: receiverId));

    final result = await _friendsRepo.cancelFriendRequest(
      receiverId: receiverId,
    );

    result.fold(
      (failure) => emit(
        CancelFriendRequestFailure(failure.errMessage, receiverId: receiverId),
      ),
      (_) {
        pendingIds.remove(receiverId);
        emit(CancelFriendRequestSuccess(receiverId: receiverId));
      },
    );
  }

  Future<void> removeFriend({required String friendId}) async {
    emit(RemoveFriendLoading(friendId: friendId));

    final result = await _friendsRepo.removeFriend(friendId: friendId);

    result.fold(
      (failure) {
        emit(RemoveFriendFailure(failure.errMessage, friendId: friendId));
      },
      (_) {
        emit(RemoveFriendSuccess(friendId: friendId));
      },
    );
  }

  Future<void> acceptFriendRequest({
    required String senderId,
    required String senderUsername,
    required int senderBestStreak,
  }) async {
    emit(AcceptFriendRequestLoading(senderId: senderId));

    final result = await _friendsRepo.acceptFriendRequest(
      senderId: senderId,
      senderUsername: senderUsername,
      senderBestStreak: senderBestStreak,
    );

    result.fold(
      (failure) {
        emit(
          AcceptFriendRequestFailure(failure.errMessage, senderId: senderId),
        );
      },
      (_) {
        emit(AcceptFriendRequestSuccess(senderId: senderId));
      },
    );
  }

  Future<void> deleteFriendRequest({required String senderId}) async {
    emit(DeclineFriendRequestLoading(senderId: senderId));

    final result = await _friendsRepo.declineFriendRequest(senderId: senderId);

    result.fold(
      (failure) {
        emit(
          DeclineFriendRequestFailure(failure.errMessage, senderId: senderId),
        );
      },
      (_) {
        emit(DeclineFriendRequestSuccess(senderId: senderId));
      },
    );
  }

  // Future<void> getPendingRequestIds() async {
  //   final result = await _friendsRepo.getPendingRequestIds();
  //   result.fold((failure) => null, (ids) {
  //     pendingIds = ids;
  //     emit(PendingIdsLoaded(ids));
  //   });
  // }

  @override
  Future<void> close() {
    _sentRequestsSub?.cancel();
    _receivedRequestsSub?.cancel();
    _friendsSub?.cancel();
    return super.close();
  }
}
