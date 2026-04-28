import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pixel_true_app/features/community/helper/get_like_text.dart';

// TODO : add editedAt to show "Edited" flag in card
class Reply implements Likable {
  final String id;
  final String postId;
  final String commentId; // ← parent comment
  final String authorUid;
  final String authorUsername;
  final String? replyToUsername; // ← @mention (e.g. replying to another reply)
  final String content;
  @override
  final List<String> likedByUids;
  final DateTime createdAt;

  Reply({
    required this.id,
    required this.postId,
    required this.commentId,
    required this.authorUid,
    required this.authorUsername,
    this.replyToUsername,
    required this.content,
    required this.likedByUids,
    required this.createdAt,
  });

  @override
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
    content: json['content'] ?? '',
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
    'content': content,
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
    content: content,
    likedByUids: likedByUids ?? this.likedByUids,
    createdAt: createdAt,
  );

  Reply copyWithContent(String newContent) {
    return Reply(
      id: id,
      postId: postId,
      commentId: commentId,
      authorUid: authorUid,
      authorUsername: authorUsername,
      replyToUsername: replyToUsername,
      content: newContent,
      likedByUids: likedByUids,
      createdAt: createdAt,
    );
  }
}
