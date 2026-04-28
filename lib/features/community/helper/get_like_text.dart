String getLikeText<T extends Likable>(String currentUserUid, T unit) {
  if (unit.isLikedBy(currentUserUid)) return "UNLIKE (${unit.likedByUids.length})";

  if (unit.likedByUids.isEmpty) return "LIKE";

  return "LIKE (${unit.likedByUids.length})";
}

abstract class Likable {
  bool isLikedBy(String uid);
  List<String> get likedByUids;
}
