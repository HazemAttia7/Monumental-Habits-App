String getDurationText(Duration duration) {
  return "${duration.inHours}h ${duration.inMinutes.remainder(60)}m";
}
