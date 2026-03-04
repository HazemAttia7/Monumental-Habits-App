import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pixel_true_app/features/home/data/local/habit_isar.dart';

class IsarService {
  static Isar? _instance;

  static Future<Isar> getInstance() async {
    if (_instance != null && _instance!.isOpen) return _instance!;
    
    final dir = await getApplicationDocumentsDirectory(); 
    
    _instance = await Isar.open(
      [HabitIsarSchema],
      directory: dir.path,   
      inspector: true,    
    );
    return _instance!;
  }
}