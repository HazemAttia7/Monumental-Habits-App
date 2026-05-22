import 'package:flutter/material.dart';

class FriendsLoadingView extends StatelessWidget {
  const FriendsLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement shimmer
    return const Center(child: CircularProgressIndicator());
  }
}
