import 'dart:async';

class Scheduler {
  final Duration interval;
  Timer? timer;
  final Function callback;

  Scheduler({required this.interval, required this.callback});

  bool get isRunning => timer?.isActive ?? false;

  void start() {
    timer = Timer.periodic(interval, (timer) {
      callback();
    });
  }

  void stop() {
    if (timer == null) return;
    timer!.cancel();
  }
}
