import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pixel_true_app/core/errors/failure.dart';
import 'package:pixel_true_app/features/friends/data/repos/friends_repo.dart';

class FriendsRepoImpl implements FriendsRepo {
  final FirebaseFirestore _firestore;

  FriendsRepoImpl({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<Either<Failure, void>> sendFriendRequest({
    required String receiverId,
  }) async {
    try {
      final senderId = FirebaseAuth.instance.currentUser!.uid;

      // Sender's outgoing request
      final senderData = {
        'senderId': senderId,
        'receiverId': receiverId,
        'status': 'pending',
        'type': 'outgoing',
        'createdAt': FieldValue.serverTimestamp(),
      };

      // Receiver's incoming request
      final receiverData = {
        'senderId': senderId,
        'receiverId': receiverId,
        'status': 'pending',
        'type': 'incoming',
        'createdAt': FieldValue.serverTimestamp(),
      };

      await _firestore
          .collection('users')
          .doc(senderId)
          .collection('friendRequests')
          .doc(receiverId)
          .set(senderData);

      await _firestore
          .collection('users')
          .doc(receiverId)
          .collection('friendRequests')
          .doc(senderId)
          .set(receiverData);

      return right(null);
    } on FirebaseException catch (e) {
      return left(FirebaseFailure(e.message ?? 'Firebase error'));
    } catch (e) {
      return left(FirebaseFailure.fromException(e as Exception));
    }
  }

  @override
  Future<Either<Failure, void>> cancelFriendRequest({
    required String receiverId,
  }) async {
    try {
      final senderId = FirebaseAuth.instance.currentUser!.uid;

      // Delete from sender's outgoing requests
      await _firestore
          .collection('users')
          .doc(senderId)
          .collection('friendRequests')
          .doc(receiverId)
          .delete();

      // Delete from receiver's incoming requests
      await _firestore
          .collection('users')
          .doc(receiverId)
          .collection('friendRequests')
          .doc(senderId)
          .delete();

      return right(null);
    } on FirebaseException catch (e) {
      return left(FirebaseFailure(e.message ?? 'Firebase error'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getPendingRequestIds() async {
    try {
      final currentUserId = FirebaseAuth.instance.currentUser!.uid;

      final snapshot = await _firestore
          .collection('users')
          .doc(currentUserId)
          .collection('friendRequests')
          .where('type', isEqualTo: 'outgoing')
          .where('status', isEqualTo: 'pending')
          .get();

      final ids = snapshot.docs.map((doc) => doc.id).toList();

      return right(ids);
    } on FirebaseException catch (e) {
      return left(FirebaseFailure(e.message ?? 'Firebase error'));
    }
  }
}
