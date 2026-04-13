import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String authorUid;
  final String authorUsername;
  final String content;
  final List<String> likedByUids;
  final int commentsCount;
  final DateTime createdAt;

  Post({
    required this.id,
    required this.authorUid,
    required this.authorUsername,
    required this.content,
    required this.likedByUids,
    required this.commentsCount,
    required this.createdAt,
  });

  bool isLikedBy(String uid) => likedByUids.contains(uid);
  int get likesCount => likedByUids.length;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json['id'] ?? '',
    authorUid: json['authorUid'] ?? '',
    authorUsername: json['authorUsername'] ?? '',
    content: json['content'] ?? '',
    likedByUids: List<String>.from(json['likedByUids'] ?? []),
    commentsCount: json['commentsCount'] ?? 0,
    createdAt: (json['createdAt'] as Timestamp).toDate(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'authorUid': authorUid,
    'authorUsername': authorUsername,
    'content': content,
    'likedByUids': likedByUids,
    'commentsCount': commentsCount,
    'createdAt': Timestamp.fromDate(createdAt),
  };

  Post copyWith({
    List<String>? likedByUids,
    int? commentsCount,
    String? content,
  }) => Post(
    id: id,
    authorUid: authorUid,
    authorUsername: authorUsername,
    content: content ?? this.content,
    likedByUids: likedByUids ?? this.likedByUids,
    commentsCount: commentsCount ?? this.commentsCount,
    createdAt: createdAt,
  );
}
