import 'package:firebase_auth/firebase_auth.dart';

abstract class Failure {
  final String errMessage;
  const Failure(this.errMessage);
}

class FirebaseFailure extends Failure {
  const FirebaseFailure(super.errMessage);

  factory FirebaseFailure.fromFirebaseAuth(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-credential':
        return const FirebaseFailure(
          'Invalid email or password. Please try again.',
        );
      case 'invalid-email':
        return const FirebaseFailure('The email address is badly formatted.');
      case 'user-disabled':
        return const FirebaseFailure('This user account has been disabled.');
      case 'email-already-in-use':
        return const FirebaseFailure('This email is already registered.');
      case 'weak-password':
        return const FirebaseFailure('The password is too weak.');
      case 'operation-not-allowed':
        return const FirebaseFailure('This operation is not allowed.');
      case 'too-many-requests':
        return const FirebaseFailure('Too many requests. Try again later.');
      case 'network-request-failed':
        return const FirebaseFailure('No internet connection.');
      default:
        if (e.code == 'unknown' &&
            (e.message?.contains('CONFIGURATION_NOT_FOUND') ?? false)) {
          return const FirebaseFailure(
            'Firebase Auth is not configured correctly. Please contact support or try again later.',
          );
        }
        return FirebaseFailure(
          'Unexpected Firebase error: ${e.message ?? 'Unknown error'}',
        );
    }
  }

  factory FirebaseFailure.fromException(Exception e) {
    if (e is FirebaseAuthException) {
      return FirebaseFailure.fromFirebaseAuth(e);
    } else {
      return const FirebaseFailure('An unknown Firebase error occurred.');
    }
  }
}
