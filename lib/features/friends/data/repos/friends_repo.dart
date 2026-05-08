import 'package:dartz/dartz.dart';
import 'package:pixel_true_app/core/errors/failure.dart';

abstract class FriendsRepo {
  Future<Either<Failure, void>> sendFriendRequest({required String receiverId});
  Future<Either<Failure, void>> cancelFriendRequest({required String receiverId});
  Future<Either<Failure, List<String>>> getPendingRequestIds();
}