import 'package:flutter/material.dart';
import 'package:pixel_true_app/features/home/presentation/views/widgets/home_view_body.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>   with AutomaticKeepAliveClientMixin{
 @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
        super.build(context); 
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: HomeViewBody(),
    );
  }
}
