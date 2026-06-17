import 'package:dartz/dartz.dart';
import 'package:pixel_true_app/core/errors/failure.dart';
import 'package:pixel_true_app/features/friends/data/models/friend_model.dart';
import 'package:pixel_true_app/features/friends/data/models/friend_request_model.dart';
import 'package:pixel_true_app/models/user_profile_model.dart';

abstract class FriendsRepo {
  Future<Either<Failure, void>> sendFriendRequest({required String receiverId , required String receiverUsername});
  Future<Either<Failure, void>> cancelFriendRequest({
    required String receiverId,
  });
  Future<Either<Failure, void>> acceptFriendRequest({
    required String senderId,
    required String senderUsername,
    required int senderBestStreak,
  });
  Future<Either<Failure, void>> declineFriendRequest({
    required String senderId,
  });
  // TODO : remove friend
  Future<Either<Failure, List<String>>> getPendingRequestIds();
  Stream<Either<Failure, List<FriendRequest>>> getIncomingFriendRequests();
  Stream<Either<Failure, List<FriendRequest>>> getOutgoingFriendRequests();
  Future<Either<Failure, List<UserProfile>>> searchUsersByUsername(String query);
  Stream<Either<Failure, List<Friend>>> getFriends();
}
