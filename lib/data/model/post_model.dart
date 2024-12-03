import '../../utils/timer_controller.dart';

class Post {
  final int id;
  final String title;
  final String body;
  bool read;
  final int timerDuration;
  TimerController timerController;

  Post({
    required this.id,
    required this.title,
    required this.body,
    this.read = false,
    required this.timerDuration,
    required this.timerController,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      read: false,
      timerDuration: (10 + (new DateTime.now().millisecondsSinceEpoch % 15) % 10), // Random duration
      timerController: TimerController(),
    );
  }

  Post copyWith({
    int? id,
    String? title,
    String? body,
    bool? read,
    int? timerDuration,
    TimerController? timerController,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      read: read ?? this.read,
      timerDuration: timerDuration ?? this.timerDuration,
      timerController: timerController ?? this.timerController,
    );
  }
}
