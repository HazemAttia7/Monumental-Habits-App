import 'package:cloud_firestore/cloud_firestore.dart';

class Reply {
  final String id;
  final String postId;
  final String commentId; // ← parent comment
  final String authorUid;
  final String authorUsername;
  final String? replyToUsername; // ← @mention (e.g. replying to another reply)
  final String text;
  final List<String> likedByUids;
  final DateTime createdAt;

  Reply({
    required this.id,
    required this.postId,
    required this.commentId,
    required this.authorUid,
    required this.authorUsername,
    this.replyToUsername,
    required this.text,
    required this.likedByUids,
    required this.createdAt,
  });

  bool isLikedBy(String uid) => likedByUids.contains(uid);
  int get likesCount => likedByUids.length;

  factory Reply.fromJson(
    Map<String, dynamic> json,
    String postId,
    String commentId,
  ) => Reply(
    id: json['id'] ?? '',
    postId: postId,
    commentId: commentId,
    authorUid: json['authorUid'] ?? '',
    authorUsername: json['authorUsername'] ?? '',
    replyToUsername: json['replyToUsername'],
    text: json['text'] ?? '',
    likedByUids: List<String>.from(json['likedByUids'] ?? []),
    createdAt: (json['createdAt'] as Timestamp).toDate(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'postId': postId,
    'commentId': commentId,
    'authorUid': authorUid,
    'authorUsername': authorUsername,
    if (replyToUsername != null) 'replyToUsername': replyToUsername,
    'text': text,
    'likedByUids': likedByUids,
    'createdAt': Timestamp.fromDate(createdAt),
  };

  Reply copyWith({List<String>? likedByUids}) => Reply(
    id: id,
    postId: postId,
    commentId: commentId,
    authorUid: authorUid,
    authorUsername: authorUsername,
    replyToUsername: replyToUsername,
    text: text,
    likedByUids: likedByUids ?? this.likedByUids,
    createdAt: createdAt,
  );
}
