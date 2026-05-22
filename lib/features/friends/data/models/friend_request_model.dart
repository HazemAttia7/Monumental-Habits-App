class FriendRequest {
  final String senderId;
  final String username;
  final int bestStreak;

  FriendRequest({
    required this.senderId,
    required this.username,
    required this.bestStreak,
  });

  factory FriendRequest.fromJson(
    String senderId,
    Map<String, dynamic> map,
  ) {
    return FriendRequest(
      senderId: senderId,
      username: map['senderUsername'] ?? '',
      bestStreak: map['senderBestStreak'] ?? 0,
    );
  }
}