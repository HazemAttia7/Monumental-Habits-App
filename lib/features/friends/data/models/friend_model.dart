class Friend {
  final String uid;
  final String username;
  final int bestStreak;

  Friend({
    required this.uid,
    required this.username,
    required this.bestStreak,
  });

  factory Friend.fromJson(String uid, Map<String, dynamic> json) => Friend(
    uid: uid,
    username: json['username'] ?? '',
    bestStreak: json['bestStreak'] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    'username': username,
    'bestStreak': bestStreak,
  };
}