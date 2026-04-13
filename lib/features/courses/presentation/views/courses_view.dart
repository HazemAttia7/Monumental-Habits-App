import 'package:flutter/material.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/courses_view_body.dart';

class CoursesView extends StatefulWidget {
  const CoursesView({super.key});

  @override
  State<CoursesView> createState() => _CoursesViewState();
}

class _CoursesViewState extends State<CoursesView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const Scaffold(body: CoursesViewBody());
  }
}
