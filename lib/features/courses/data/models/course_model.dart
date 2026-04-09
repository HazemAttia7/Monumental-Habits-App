import 'package:pixel_true_app/features/courses/data/models/lesson_model.dart';

class Course {
  final String? id;
  final String title;
  final String? imageUrl;
  final Duration duration;
  final List<Lesson> lessons;

  Course({
    this.id,
    required this.title,
    this.imageUrl,
    required this.duration,
    required this.lessons,
  });

  factory Course.fromJson(Map<String, dynamic> json, String docId) {
    return Course(
      id: docId,
      title: json['title'],
      imageUrl: json['imageUrl'],
      duration: Duration(milliseconds: json['duration']),
      lessons: (json['lessons'] as List)
          .map((e) => Lesson.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'imageUrl': imageUrl,
    'duration': duration.inMilliseconds,
    'lessons': lessons.map((e) => e.toJson()).toList(),
  };
}
