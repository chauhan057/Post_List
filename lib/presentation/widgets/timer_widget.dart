import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class TimerIcon extends StatefulWidget {
  final int postId;

  TimerIcon({required this.postId});

  @override
  _TimerIconState createState() => _TimerIconState();
}

class _TimerIconState extends State<TimerIcon> with TickerProviderStateMixin {
  late AnimationController _controller;
  late int _remainingTime;
  late int _totalTime;

  @override
  void initState() {
    super.initState();
    _totalTime = _generateRandomTimerDuration();
    _remainingTime = _totalTime;

    _controller = AnimationController(vsync: this, duration: Duration(seconds: _totalTime))
      ..addListener(() {
        setState(() {
          _remainingTime = (_totalTime - _controller.value * _totalTime).round();
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startTimer() {
    _controller.forward(from: 0.0);
  }

  void _pauseTimer() {
    _controller.stop();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.timer),
      onPressed: _startTimer,
      iconSize: 30,
    );
  }

  int _generateRandomTimerDuration() {
    return [10, 20, 25][Random().nextInt(3)]; // Random timer between 10, 20, and 25 seconds
  }
}
