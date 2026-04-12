String formatCount(int count) {
  if (count < 1000) return count.toString();

  if (count < 1000000) {
    double value = count / 1000;
    return value % 1 == 0
        ? '${value.toInt()}k'
        : '${value.toStringAsFixed(1)}k';
  }

  double value = count / 1000000;
  return value % 1 == 0 ? '${value.toInt()}M' : '${value.toStringAsFixed(1)}M';
}
