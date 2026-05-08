import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pixel_true_app/features/friends/data/repos/friends_repo.dart';

part 'friends_state.dart';

class FriendsCubit extends Cubit<FriendsState> {
  final FriendsRepo _friendsRepo;
  FriendsCubit(this._friendsRepo) : super(FriendsInitial());

  List<String> pendingIds = [];

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

  Future<void> getPendingRequestIds() async {
    final result = await _friendsRepo.getPendingRequestIds();
    result.fold((failure) => null, (ids) {
      pendingIds = ids;
      emit(PendingIdsLoaded(ids));
    });
  }
}
