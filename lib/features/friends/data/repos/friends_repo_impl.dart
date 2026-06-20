import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pixel_true_app/core/errors/failure.dart';
import 'package:pixel_true_app/features/friends/data/models/friend_model.dart';
import 'package:pixel_true_app/features/friends/data/models/friend_request_model.dart';
import 'package:pixel_true_app/features/friends/data/repos/friends_repo.dart';
import 'package:pixel_true_app/models/user_profile_model.dart';

class FriendsRepoImpl implements FriendsRepo {
  final FirebaseFirestore _firestore;

  FriendsRepoImpl({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Stream<Either<Failure, List<Friend>>> getFriends() {
    try {
      final currentUserId = FirebaseAuth.instance.currentUser!.uid;

      return _firestore
          .collection('users')
          .doc(currentUserId)
          .collection('friends')
          .snapshots()
          .map((snapshot) {
            final friends = snapshot.docs
                .map((doc) => Friend.fromJson(doc.id, doc.data()))
                .toList();
            return right<Failure, List<Friend>>(friends);
          });
    } on FirebaseException catch (e) {
      return Stream.value(left(FirebaseFailure(e.message ?? 'Firebase error')));
    }
  }

  @override
  Stream<Either<Failure, List<FriendRequest>>> getIncomingFriendRequests() {
    try {
      final currentUserId = FirebaseAuth.instance.currentUser!.uid;

      return _firestore
          .collection('users')
          .doc(currentUserId)
          .collection('friendRequests')
          .where('type', isEqualTo: 'incoming')
          .where('status', isEqualTo: 'pending')
          .snapshots()
          .map((snapshot) {
            final requests = snapshot.docs
                .map((doc) => FriendRequest.fromJson(doc.id, doc.data()))
                .toList();

            return right<Failure, List<FriendRequest>>(requests);
          });
    } on FirebaseException catch (e) {
      return Stream.value(left(FirebaseFailure(e.message ?? 'Firebase error')));
    }
  }

  @override
  Stream<Either<Failure, List<FriendRequest>>> getOutgoingFriendRequests() {
    try {
      final currentUserId = FirebaseAuth.instance.currentUser!.uid;

      return _firestore
          .collection('users')
          .doc(currentUserId)
          .collection('friendRequests')
          .where('type', isEqualTo: 'outgoing')
          .where('status', isEqualTo: 'pending')
          .snapshots()
          .map((snapshot) {
            final requests = snapshot.docs
                .map((doc) => FriendRequest.fromJson(doc.id, doc.data()))
                .toList();

            return right<Failure, List<FriendRequest>>(requests);
          });
    } on FirebaseException catch (e) {
      return Stream.value(left(FirebaseFailure(e.message ?? 'Firebase error')));
    }
  }

  @override
  Future<Either<Failure, void>> sendFriendRequest({
    required String receiverId,
    required String receiverUsername,
  }) async {
    try {
      final senderId = FirebaseAuth.instance.currentUser!.uid;

      final senderDoc = await _firestore
          .collection('users')
          .doc(senderId)
          .get();

      final senderData = senderDoc.data();

      final senderUsername = senderData?['username'] ?? '';
      final senderBestStreak = senderData?['bestStreak'] ?? 0;

      final batch = _firestore.batch();

      // Sender's outgoing request
      batch.set(
        _firestore
            .collection('users')
            .doc(senderId)
            .collection('friendRequests')
            .doc(receiverId),
        {
          'senderId': senderId,
          'receiverId': receiverId,
          'receiverUsername': receiverUsername,
          'senderUsername': senderUsername,
          'senderBestStreak': senderBestStreak,
          'status': 'pending',
          'type': 'outgoing',
          'createdAt': FieldValue.serverTimestamp(),
        },
      );

      // Receiver's incoming request
      batch.set(
        _firestore
            .collection('users')
            .doc(receiverId)
            .collection('friendRequests')
            .doc(senderId),
        {
          'senderId': senderId,
          'receiverId': receiverId,
          'receiverUsername': receiverUsername,
          'senderUsername': senderUsername,
          'senderBestStreak': senderBestStreak,
          'status': 'pending',
          'type': 'incoming',
          'createdAt': FieldValue.serverTimestamp(),
        },
      );

      await batch.commit();

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

      final batch = _firestore.batch();

      batch.delete(
        _firestore
            .collection('users')
            .doc(senderId)
            .collection('friendRequests')
            .doc(receiverId),
      );

      batch.delete(
        _firestore
            .collection('users')
            .doc(receiverId)
            .collection('friendRequests')
            .doc(senderId),
      );

      await batch.commit();

      return right(null);
    } on FirebaseException catch (e) {
      return left(FirebaseFailure(e.message ?? 'Firebase error'));
    }
  }

  @override
  Future<Either<Failure, void>> removeFriend({required String friendId}) async {
    try {
      final currentUserId = FirebaseAuth.instance.currentUser!.uid;

      final batch = _firestore.batch();

      // Remove friend from current user's friends list
      batch.delete(
        _firestore
            .collection('users')
            .doc(currentUserId)
            .collection('friends')
            .doc(friendId),
      );

      // Remove current user from the other user's friends list
      batch.delete(
        _firestore
            .collection('users')
            .doc(friendId)
            .collection('friends')
            .doc(currentUserId),
      );

      await batch.commit();

      return right(null);
    } on FirebaseException catch (e) {
      return left(FirebaseFailure(e.message ?? 'Firebase error'));
    }
  }

  @override
  Future<Either<Failure, void>> acceptFriendRequest({
    required String senderId,
    required String senderUsername,
    required int senderBestStreak,
  }) async {
    try {
      final currentUserId = FirebaseAuth.instance.currentUser!.uid;

      final currentUserDoc = await _firestore
          .collection('users')
          .doc(currentUserId)
          .get();
      final currentUsername = currentUserDoc.data()!['username'] as String;
      final currentBestStreak =
          currentUserDoc.data()!['bestStreak'] as int? ?? 0;

      final batch = _firestore.batch();

      // Add sender to current user's friends
      batch.set(
        _firestore
            .collection('users')
            .doc(currentUserId)
            .collection('friends')
            .doc(senderId),
        {
          'uid': senderId,
          'username': senderUsername,
          'bestStreak': senderBestStreak,
        },
      );

      // Add current user to sender's friends
      batch.set(
        _firestore
            .collection('users')
            .doc(senderId)
            .collection('friends')
            .doc(currentUserId),
        {
          'uid': currentUserId,
          'username': currentUsername,
          'bestStreak': currentBestStreak,
        },
      );

      // Delete from current user's incoming requests
      batch.delete(
        _firestore
            .collection('users')
            .doc(currentUserId)
            .collection('friendRequests')
            .doc(senderId),
      );

      // Delete from sender's outgoing requests
      batch.delete(
        _firestore
            .collection('users')
            .doc(senderId)
            .collection('friendRequests')
            .doc(currentUserId),
      );

      await batch.commit();

      return right(null);
    } on FirebaseException catch (e) {
      return left(FirebaseFailure(e.message ?? 'Firebase error'));
    }
  }

  @override
  Future<Either<Failure, void>> declineFriendRequest({
    required String senderId,
  }) async {
    try {
      final currentUserId = FirebaseAuth.instance.currentUser!.uid;

      final batch = _firestore.batch();

      // Delete incoming request from current user
      batch.delete(
        _firestore
            .collection('users')
            .doc(currentUserId)
            .collection('friendRequests')
            .doc(senderId),
      );

      // Delete outgoing request from sender
      batch.delete(
        _firestore
            .collection('users')
            .doc(senderId)
            .collection('friendRequests')
            .doc(currentUserId),
      );

      await batch.commit();

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

  @override
  Future<Either<Failure, List<UserProfile>>> searchUsersByUsername(
    String query,
  ) async {
    try {
      final normalized = query.trim().toLowerCase();

      if (normalized.isEmpty) {
        return right([]);
      }

      // Requires a 'usernameLower' field on each user document.
      // If your existing users don't have it yet, see migration note below.
      final snapshot = await _firestore
          .collection('users')
          .where('username_lower', isGreaterThanOrEqualTo: normalized)
          .where('username_lower', isLessThan: '$normalized\uf8ff')
          .limit(20)
          .get();

      final users = snapshot.docs
          .map((doc) => UserProfile.fromJson(doc.data()))
          .toList();

      return right(users);
    } on FirebaseException catch (e) {
      return left(FirebaseFailure(e.message ?? 'Firebase error'));
    }
  }
}
