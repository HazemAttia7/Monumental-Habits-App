import 'package:isar/isar.dart';

part 'habit_isar.g.dart';

@collection
class HabitIsar {
  // Isar needs an int Id — we hash our string id
  Id get id => fastHash(habitId);

  late String habitId;
  late String uid; // owner — needed for multi-account edge cases
  late String name;
  late List<int> frequency;
  late List<String> reminders;
  late String
  logsJson; // Map<String, String> serialized — Isar can't store Maps
  late String status;
  late DateTime createdAt;

  // Sync metadata
  late bool isSynced;
  late bool isDeleted; // soft delete flag
  late DateTime updatedAt; // last write wins uses this
}

Id fastHash(String string) {
  var hash = 0xcbf29ce484222325;
  for (var i = 0; i < string.length; i++) {
    hash ^= string.codeUnitAt(i);
    hash *= 0x100000001b3;
    hash &= 0xFFFFFFFFFFFFFFFF;
  }
  return hash;
}
