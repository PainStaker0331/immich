extension DurationExtension on String {
  Duration toDuration() {
    final parts =
        split(':').map((e) => double.parse(e).toInt()).toList(growable: false);
    return Duration(hours: parts[0], minutes: parts[1], seconds: parts[2]);
  }

  double toDouble() {
    return double.parse(this);
  }

  int toInt() {
    return int.parse(this);
  }
}
