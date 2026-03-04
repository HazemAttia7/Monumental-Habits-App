import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final String uid;
  final String username;
  final String email;
  final bool emailMe;
  final DateTime? createdAt;
  // references only — actual data fetched by their own cubits
  final List<String> friendUids;
  final List<String> savedCourseIds;

  UserProfile({
    required this.uid,
    required this.username,
    required this.email,
    required this.emailMe,
    this.createdAt,
    this.friendUids = const [],
    this.savedCourseIds = const [],
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    uid: json['uid'] ?? '',
    username: json['username'] ?? '',
    email: json['email'] ?? '',
    emailMe: json['emailMe'] ?? false,
    createdAt: (json['createdAt'] as Timestamp?)?.toDate(),
    friendUids: List<String>.from(json['friendUids'] ?? []),
    savedCourseIds: List<String>.from(json['savedCourseIds'] ?? []),
  );

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'username': username,
    'email': email,
    'emailMe': emailMe,
    'friendUids': friendUids,
    'savedCourseIds': savedCourseIds,
  };

  UserProfile copyWith({
    String? username,
    String? email,
    bool? emailMe,
    List<String>? friendUids,
    List<String>? savedCourseIds,
  }) => UserProfile(
    uid: uid,
    username: username ?? this.username,
    email: email ?? this.email,
    emailMe: emailMe ?? this.emailMe,
    createdAt: createdAt,
    friendUids: friendUids ?? this.friendUids,
    savedCourseIds: savedCourseIds ?? this.savedCourseIds,
  );
}
