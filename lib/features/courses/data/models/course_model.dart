import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pixel_true_app/features/courses/data/models/lesson_model.dart';

class Course {
  final String? id;
  final String title;
  final String? imageUrl;
  final Duration duration;
  final List<Lesson> lessons;
  final DateTime publishedAt;
  final bool isSaved;
  final int lastWatchedLesson;

  Course({
    this.id,
    required this.title,
    this.imageUrl,
    required this.duration,
    required this.lessons,
    required this.publishedAt,
    this.isSaved = false,
    this.lastWatchedLesson = 0,
  });

  Course copyWith({bool? isSaved, int? lastWatchedLesson}) {
    return Course(
      id: id,
      title: title,
      imageUrl: imageUrl,
      duration: duration,
      lessons: lessons,
      publishedAt: publishedAt,
      isSaved: isSaved ?? this.isSaved,
      lastWatchedLesson: lastWatchedLesson ?? this.lastWatchedLesson,
    );
  }

  factory Course.fromJson(Map<String, dynamic> json, String docId) {
    return Course(
      id: docId,
      title: json['title'],
      imageUrl: json['imageUrl'],
      duration: Duration(milliseconds: json['duration']),
      lessons: (json['lessons'] as List)
          .map((e) => Lesson.fromJson(e))
          .toList(),
      publishedAt: (json['publishedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'imageUrl': imageUrl,
    'duration': duration.inMilliseconds,
    'lessons': lessons.map((e) => e.toJson()).toList(),
    'publishedAt': Timestamp.fromDate(publishedAt),
  };
}
