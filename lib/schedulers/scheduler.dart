import 'dart:async';

class Scheduler {
  final Duration interval;
  late Timer timer;
  final Function callback;

  Scheduler({required this.interval, required this.callback});

  void start() {
    timer = Timer.periodic(interval, (timer) {
      callback();
    });
  }

  void stop() {
    timer.cancel();
  }
}
