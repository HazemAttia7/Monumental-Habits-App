import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pixel_true_app/features/home/data/models/habit_model.dart';

class HabitsRemoteDataSource {
  final FirebaseFirestore _firestore;
  HabitsRemoteDataSource({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference _ref(String uid) =>
      _firestore.collection('users').doc(uid).collection('habits');

  Future<List<Habit>> getHabits(String uid) async {
    final snapshot = await _ref(uid).get();
    return snapshot.docs
        .map((d) => Habit.fromJson(d.data() as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveHabit(String uid, Habit habit) async {
    await _ref(uid).doc(habit.id).set(habit.toJson());
  }

  Future<void> deleteHabit(String uid, String habitId) async {
    await _ref(uid).doc(habitId).delete();
  }

  Future<void> updateLog(
    String uid,
    String habitId,
    String dateKey,
    String statusName,
  ) async {
    await _ref(uid).doc(habitId).update({'logs.$dateKey': statusName});
  }
}