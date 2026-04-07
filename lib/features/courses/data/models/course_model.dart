class Course {
  String imageUrl, title;
  final Duration duration;
  final int lessons;
  final bool isFavourite;
  Course({
    required this.imageUrl,
    required this.title,
    required this.duration,
    required this.lessons,
    this.isFavourite = false,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    imageUrl: json['image'] as String,
    title: json['title'] as String,
    duration: json['duration'] as Duration,
    lessons: json['lessons'] as int,
    isFavourite: json['isFavourite'] as bool,
  );

  Map<String, dynamic> toJson() => {
    'image': imageUrl,
    'title': title,
    'isFavourite': isFavourite,
    'duration': duration,
    'lessons': lessons,
  };
}
