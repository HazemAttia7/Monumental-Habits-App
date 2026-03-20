import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppUser extends Equatable {
  final String uid;
  final String email;
  final String name;

  const AppUser({required this.uid, required this.email, required this.name});

  factory AppUser.fromFirebaseUser(User user) {
    return AppUser(
      uid: user.uid,
      email: user.email ?? '',
      name: user.displayName ?? '',
    );
  }

  Map<String, dynamic> toJSON() {
    return {'uid': uid, 'email': email, 'name': name};
  }

  factory AppUser.fromJSON(Map<String, dynamic> json) {
    return AppUser(uid: json['uid'], email: json['email'], name: json['name']);
  }

  AppUser copyWith({String? uid, String? email, String? name}) {
    return AppUser(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props => [uid, name, email];
}
