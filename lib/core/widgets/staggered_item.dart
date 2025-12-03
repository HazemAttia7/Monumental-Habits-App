import 'package:flutter/material.dart';

class StaggeredItem extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const StaggeredItem({
    super.key,
    required this.child,
    required this.delay,
  });

  @override
  State<StaggeredItem> createState() => _StaggeredItemState();
}

class _StaggeredItemState extends State<StaggeredItem> {
  bool _show = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delay, () {
      if (mounted) {
        setState(() {
          _show = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _show ? widget.child : const SizedBox.shrink();
  }
}