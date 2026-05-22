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

  List<FriendRequest> _friendRequests = [];
  List<Friend> _friends = [];
  bool _requestsLoaded = false;
  bool _friendsLoaded = false;

  StreamSubscription? _friendRequestsSub;
  StreamSubscription? _friendsSub;

  void _emitIfBothLoaded() {
    if (_requestsLoaded && _friendsLoaded) {
      emit(FriendsViewLoaded(requests: _friendRequests, friends: _friends));
    }
  }

  void getIncomingFriendRequests() {
    _friendRequestsSub?.cancel();
    _friendRequestsSub = _friendsRepo.getIncomingFriendRequests().listen((
      result,
    ) {
      result.fold(
        (failure) => emit(FriendRequestsFailure(failure.errMessage)),
        (requests) {
          _friendRequests = requests;
          _requestsLoaded = true;
          _emitIfBothLoaded();
        },
      );
    });
  }

  void getFriends() {
    _friendsSub?.cancel();
    _friendsSub = _friendsRepo.getFriends().listen((result) {
      result.fold((failure) => emit(FriendsFailure(failure.errMessage)), (
        friends,
      ) {
        _friends = friends;
        _friendsLoaded = true;
        _emitIfBothLoaded();
      });
    });
  }

  Future<void> sendFriendRequest({required String receiverId}) async {
    emit(SendFriendRequestLoading(receiverId: receiverId));

    final result = await _friendsRepo.sendFriendRequest(receiverId: receiverId);

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

  Future<void> declineFriendRequest({required String senderId}) async {
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

  Future<void> getPendingRequestIds() async {
    final result = await _friendsRepo.getPendingRequestIds();
    result.fold((failure) => null, (ids) {
      pendingIds = ids;
      emit(PendingIdsLoaded(ids));
    });
  }

  @override
  Future<void> close() {
    _friendRequestsSub?.cancel();
    _friendsSub?.cancel();
    return super.close();
  }
}
