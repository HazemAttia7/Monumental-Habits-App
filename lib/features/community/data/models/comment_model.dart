import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pixel_true_app/features/community/helper/get_like_text.dart';

class Comment implements Likable {
  final String id;
  final String postId;
  final String authorUid;
  final String authorUsername;
  final String content;
  @override
  final List<String> likedByUids;
  final DateTime createdAt;

  Comment({
    required this.id,
    required this.postId,
    required this.authorUid,
    required this.authorUsername,
    required this.content,
    required this.likedByUids,
    required this.createdAt,
  });

  @override
  bool isLikedBy(String uid) => likedByUids.contains(uid);
  int get likesCount => likedByUids.length;

  factory Comment.fromJson(Map<String, dynamic> json, String postId) => Comment(
    id: json['id'] ?? '',
    postId: postId,
    authorUid: json['authorUid'] ?? '',
    authorUsername: json['authorUsername'] ?? '',
    content: json['content'] ?? '',
    likedByUids: List<String>.from(json['likedByUids'] ?? []),
    createdAt: (json['createdAt'] as Timestamp).toDate(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'postId': postId,
    'authorUid': authorUid,
    'authorUsername': authorUsername,
    'content': content,
    'likedByUids': likedByUids,
    'createdAt': Timestamp.fromDate(createdAt),
  };

  Comment copyWith({List<String>? likedByUids}) => Comment(
    id: id,
    postId: postId,
    authorUid: authorUid,
    authorUsername: authorUsername,
    content: content,
    likedByUids: likedByUids ?? this.likedByUids,
    createdAt: createdAt,
  );
}
