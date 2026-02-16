import 'package:flutter/material.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_new_habit_body.dart';

class AddNewHabit extends StatelessWidget {
  final VoidCallback? backToHome;
  const AddNewHabit({super.key,  this.backToHome});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: AddNewHabitBody(backToHome: backToHome ));
  }
}
