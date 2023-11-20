import 'dart:async';
import 'package:flutter/material.dart';

class Shaker extends StatefulWidget {
  final Widget child;
  final Stream<void> stream;
  final Duration duration;
  final int loops;
  const Shaker({
    required this.child,
    required this.stream,
    this.duration = const Duration(milliseconds: 300),
    this.loops = 1,
    Key? key,
  }) : super(key: key);

  @override
  State<Shaker> createState() => _ShakerState();
}

class _ShakerState extends State<Shaker> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final StreamSubscription _subscription;
  late final Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _subscription = widget.stream.listen((event) async {
      for (var i = 0; i < widget.loops; ++i) {
        await _controller.forward();
        await _controller.reverse();
      }
    });

    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.4, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticIn,
    ));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: widget.child,
    );
  }
}
