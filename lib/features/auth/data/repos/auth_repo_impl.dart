import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pixel_true_app/core/errors/failure.dart';
import 'package:pixel_true_app/core/services/sendgrid_service.dart';
import 'package:pixel_true_app/features/auth/data/models/app_user.dart';
import 'package:pixel_true_app/features/auth/data/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  AuthRepoImpl({FirebaseFirestore? firestore, FirebaseAuth? auth})
    : _firestore = firestore ?? FirebaseFirestore.instance,
      _auth = auth ?? FirebaseAuth.instance;

  @override
  Future<Either<Failure, AppUser?>> getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        return Right(AppUser.fromFirebaseUser(user));
      }
      return const Right(null);
    } on Exception catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, AppUser>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        return Right(AppUser.fromFirebaseUser(userCredential.user!));
      }
      return const Left(FirebaseFailure("Login failed"));
    } on FirebaseAuthException catch (e) {
      try {
        final query = await _firestore
            .collection('users')
            .where('email', isEqualTo: email.trim())
            .where(
              'isGoogleUser',
              isEqualTo: true,
            ) // ← check isGoogleUser field
            .limit(1)
            .get();

        if (query.docs.isNotEmpty) {
          return const Left(
            FirebaseFailure(
              "This email is linked to Google. Please sign in with Google.",
            ),
          );
        }
      } catch (_) {}
      return Left(FirebaseFailure.fromException(e));
    } on Exception catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  Future<void> sendEmailUsingSendGrid(
    String email,
    BuildContext context,
  ) async {
    final sent = await SendGridService.sendMarketingEmail(email);
    if (sent) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Marketing email sent successfully")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to send marketing email")),
      );
    }
  }

  Future<void> addUserToFirestore(
    String useruid,
    String username,
    String email,
    bool emailMe, {
    bool isGoogleUser = false, // ← add this
  }) async {
    await _firestore.collection("users").doc(useruid).set({
      "uid": useruid,
      "username": username,
      'username_lower': username.toLowerCase(),
      "email": email,
      "emailMe": emailMe,
      "isGoogleUser": isGoogleUser, // ← add this
      "createdAt": FieldValue.serverTimestamp(),
    });
  }

  Future<bool> isUsernameExist(String username) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .where('username_lower', isEqualTo: username.toLowerCase())
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) return false;

      return snapshot.docs.isNotEmpty;
    } on FirebaseException catch (e) {
      throw FirebaseFailure("Error checking username: ${e.message}");
    } catch (e) {
      throw const FirebaseFailure("Unknown error checking username");
    }
  }

  @override
  Future<Either<Failure, AppUser>> signUpWithEmailPassword(
    BuildContext context, {
    required String username,
    required String email,
    required String password,
    required bool emailMe,
  }) async {
    try {
      if (await isUsernameExist(username)) {
        return const Left(FirebaseFailure("Username already exists"));
      }

      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;
      if (user == null) {
        return const Left(FirebaseFailure("Failed to create account"));
      }

      await user.updateDisplayName(username);
      await user.reload();

      await addUserToFirestore(user.uid, username, email, emailMe);

      if (emailMe) {
        await sendEmailUsingSendGrid(email, context);
      }

      final refreshedUser = _auth.currentUser!;
      return Right(AppUser.fromFirebaseUser(refreshedUser));
    } on FirebaseFailure catch (e) {
      return Left(e);
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseFailure.fromException(e));
    } on Exception catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await _auth.signOut();
      return const Right(unit);
    } on Exception catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> sendPasswordResetEmail({
    required String email,
  }) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return const Right(unit);
    } on Exception catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, AppUser>> signUpWithGoogle() async {
    try {
      final googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();

      final GoogleSignInAccount? gUser = await googleSignIn.signIn();

      if (gUser == null) {
        return const Left(
          FirebaseFailure("Google sign-in was cancelled by user."),
        );
      }

      final GoogleSignInAuthentication gAuth = await gUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user == null) {
        return const Left(FirebaseFailure("Failed to sign in with Google."));
      }

      final isNewUser = userCredential.additionalUserInfo?.isNewUser ?? false;
      if (isNewUser) {
        final username = user.displayName ?? gUser.email.split('@')[0];
        await addUserToFirestore(
          user.uid,
          username,
          user.email ?? '',
          false,
          isGoogleUser: true, // ← pass true
        );
      } else {
        // ← update existing Google users to have isGoogleUser field
        await _firestore.collection('users').doc(user.uid).update({
          'isGoogleUser': true,
        });
      }

      return Right(AppUser.fromFirebaseUser(user));
    } on Exception catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> verifyPassword({
    required String password,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return const Left(FirebaseFailure("No user logged in"));

      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: password,
      );
      await user.reauthenticateWithCredential(credential);
      return const Right(unit);
    } on Exception catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> changeEmail({
    required String newEmail,
    required String currentPassword,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return const Left(FirebaseFailure("No user logged in"));

      final cleanEmail = newEmail.trim();
      final oldUid = user.uid;
      final displayName = user.displayName ?? '';

      // Re-authenticate first
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );
      await user.reauthenticateWithCredential(credential);

      // Fetch EVERYTHING before deleting auth account
      final userDoc = await _firestore.collection('users').doc(oldUid).get();
      final userData = userDoc.data() ?? {};

      final habitsSnapshot = await _firestore
          .collection('users')
          .doc(oldUid)
          .collection('habits')
          .get();

      // Delete old Firebase Auth account
      await user.delete();

      // Create new Firebase Auth account with new email
      final newCredential = await _auth.createUserWithEmailAndPassword(
        email: cleanEmail,
        password: currentPassword,
      );

      final newUser = newCredential.user;
      if (newUser == null) {
        return const Left(FirebaseFailure("Failed to recreate account"));
      }

      await newUser.updateDisplayName(displayName);
      await newUser.reload();

      final batch = _firestore.batch();

      // Set new user doc with new uid (instead of updating old one)
      batch.set(_firestore.collection('users').doc(newUser.uid), {
        ...userData,
        'email': cleanEmail,
        'uid': newUser.uid,
      });

      // Delete old user doc
      batch.delete(_firestore.collection('users').doc(oldUid));

      // Move habits to new uid
      for (final doc in habitsSnapshot.docs) {
        batch.set(
          _firestore
              .collection('users')
              .doc(newUser.uid)
              .collection('habits')
              .doc(doc.id),
          doc.data(),
        );
        batch.delete(
          _firestore
              .collection('users')
              .doc(oldUid)
              .collection('habits')
              .doc(doc.id),
        );
      }

      await batch.commit();

      return const Right(unit);
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseFailure.fromException(e));
    } catch (e) {
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> changePassword({
    required String newPassword,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return const Left(FirebaseFailure("No user logged in"));

      await user.updatePassword(newPassword);

      return const Right(unit);
    } on Exception catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> changeUsername({
    required String newUsername,
  }) async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        return const Left(FirebaseFailure("No user logged in"));
      }

      if (user.displayName == newUsername) {
        return const Right(unit);
      }

      if (await isUsernameExist(newUsername)) {
        return const Left(FirebaseFailure("Username already exists"));
      }

      await user.updateDisplayName(newUsername);
      await user.reload();

      await _firestore.collection("users").doc(user.uid).update({
        "username": newUsername,
        "username_lower": newUsername.toLowerCase(),
      });

      await _updateAuthorUsernameInPosts(user.uid, newUsername);

      return const Right(unit);
    } on Exception catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  Future<void> _updateAuthorUsernameInPosts(
    String uid,
    String newUsername,
  ) async {
    try {
      final posts = await _firestore
          .collection('posts')
          .where('authorUid', isEqualTo: uid)
          .get();

      final comments = await _firestore
          .collectionGroup('comments')
          .where('authorUid', isEqualTo: uid)
          .get();

      final replies = await _firestore
          .collectionGroup('replies')
          .where('authorUid', isEqualTo: uid)
          .get();

      final allRefs = [
        ...posts.docs.map((d) => d.reference),
        ...comments.docs.map((d) => d.reference),
        ...replies.docs.map((d) => d.reference),
      ];

      const chunkSize = 500;
      for (var i = 0; i < allRefs.length; i += chunkSize) {
        final batch = _firestore.batch();
        final chunk = allRefs.sublist(
          i,
          (i + chunkSize).clamp(0, allRefs.length),
        );
        for (final ref in chunk) {
          batch.update(ref, {'authorUsername': newUsername});
        }
        await batch.commit();
      }
    } on FirebaseException catch (e) {
      // This will print the exact error code and message
      debugPrint('Firebase error: ${e.code} — ${e.message}');
      debugPrint(
        'Link to fix: ${e.message}',
      ); // index link usually appears here
      rethrow;
    }
  }

  @override
  Future<Either<Failure, bool>> isEmailAvailable(String email) async {
    try {
      final query = await _firestore
          .collection('users')
          .where('email', isEqualTo: email.trim())
          .limit(1)
          .get();

      return Right(query.docs.isEmpty);
    } catch (e) {
      return Left(FirebaseFailure.fromException(e as Exception));
    }
  }

  @override
  bool isGoogleUser() {
    final user = _auth.currentUser;

    return user?.providerData.any((p) => p.providerId == 'google.com') ?? false;
  }

  @override
  Future<Either<Failure, List<String>>> getUsernamesByUids(
    List<String> uids,
  ) async {
    try {
      final docs = await Future.wait(
        uids.map((uid) => _firestore.collection('users').doc(uid).get()),
      );
      final usernames = docs
          .map((doc) => (doc.data()?['username'] as String? ?? '??'))
          .toList();
      return Right(usernames);
    } on Exception catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }
}
