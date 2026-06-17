class FriendRequest {
  final String userId;
  final String username;
  final int bestStreak;

  FriendRequest({
    required this.userId,
    required this.username,
    required this.bestStreak,
  });

  factory FriendRequest.fromJson(String docId, Map<String, dynamic> map) {
    final type = map['type'] ?? 'incoming';
    final isOutgoing = type == 'outgoing';

    return FriendRequest(
      userId: isOutgoing
          ? (map['receiverId'] ?? docId)
          : (map['senderId'] ?? docId),
      username: isOutgoing
          ? (map['receiverUsername'] ?? '')
          : (map['senderUsername'] ?? ''),
      bestStreak: isOutgoing
          ? (map['receiverBestStreak'] ?? 0)
          : (map['senderBestStreak'] ?? 0),
    );
  }
}
