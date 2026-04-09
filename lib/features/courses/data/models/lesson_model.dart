class Lesson {
  final String title;
  final Duration duration;

  Lesson({required this.title, required this.duration});

  Map<String, dynamic> toJson() => {
    'title': title,
    'duration': duration.inMilliseconds,
  };

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
    title: json['title'],
    duration: Duration(milliseconds: json['duration']),
  );
}
