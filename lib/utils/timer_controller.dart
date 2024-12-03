import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class TimerController extends ChangeNotifier {
  late Ticker _ticker;
  int _elapsedTime = 0;
  bool _isRunning = false;

  TimerController() {
    _ticker = Ticker(_onTick);
  }

  int get elapsedTime => _elapsedTime;
  bool get isRunning => _isRunning;

  void start() {
    if (!_isRunning) {
      _isRunning = true;
      _ticker.start();
    }
  }

  void pause() {
    if (_isRunning) {
      _isRunning = false;
      _ticker.stop();
    }
  }

  void reset() {
    _elapsedTime = 0;
    notifyListeners();
  }

  void _onTick(Duration elapsed) {
    _elapsedTime = elapsed.inSeconds;
    notifyListeners();
  }
}
