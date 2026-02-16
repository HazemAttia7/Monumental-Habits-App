import 'package:flutter/material.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/add_new_habit_body.dart';

class AddNewHabit extends StatelessWidget {
  const AddNewHabit({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: AddNewHabitBody(),);
  }
}