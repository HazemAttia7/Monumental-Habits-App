String getTimeAgo(Duration postedSince) {
  final days = postedSince.inDays;
  final hours = postedSince.inHours;
  final minutes = postedSince.inMinutes;
  final seconds = postedSince.inSeconds;
  if (days > 0) {
    return "${days}d ago";
  } else if (hours > 0) {
    return "${hours}h ago";
  } else if (minutes > 0) {
    return "${minutes}m ago";
  } else {
    return "${seconds}s ago";
  }
}
