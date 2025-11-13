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
  @override
  Future<Either<Failure, AppUser?>> getCurrentUser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
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
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        return Right(AppUser.fromFirebaseUser(userCredential.user!));
      }
      return const Left(FirebaseFailure("Login failed"));
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
    bool emailMe,
  ) async {
    await FirebaseFirestore.instance.collection("users").doc(useruid).set({
      "uid": useruid,
      "username": username,
      'username_lower': username.toLowerCase(),
      "email": email,
      "emailMe": emailMe,
      "createdAt": FieldValue.serverTimestamp(),
    });
  }

  Future<bool> isUsernameExist(String username) async {
    try {
      final snapshot = await FirebaseFirestore.instance
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

      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;
      if (user == null) {
        return const Left(FirebaseFailure("Failed to create account"));
      }

      await user.updateDisplayName(username);

      await addUserToFirestore(user.uid, username, email, emailMe);

      if (emailMe) {
        await sendEmailUsingSendGrid(email, context);
      }

      return Right(AppUser.fromFirebaseUser(user));
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
      await FirebaseAuth.instance.signOut();
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
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return const Right(unit);
    } on Exception catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  Future<Either<Failure, AppUser>> signUpWithGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

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

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
      final user = userCredential.user;

      if (user == null) {
        return const Left(FirebaseFailure("Failed to sign in with Google."));
      }
      return Right(AppUser.fromFirebaseUser(user));
    } on Exception catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }
}
