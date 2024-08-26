import 'package:flutter_test/flutter_test.dart';

import 'package:onboarding/schedulers/scheduler.dart';

void main() {
  group('Scheduler', () {
    test('Callback is triggered after the specified interval', () async {
      int counter = 0;
      final scheduler = Scheduler(
        interval: const Duration(milliseconds: 100),
        callback: () {
          counter++;
        },
      );

      scheduler.start();

      // Wait for a bit more than the interval to ensure the callback has time to run
      await Future.delayed(const Duration(milliseconds: 350));

      // The callback should have been called approximately 3 times
      expect(counter, inInclusiveRange(3, 4));

      scheduler.stop();
    });

    test('Timer stops correctly', () async {
      int counter = 0;
      final scheduler = Scheduler(
        interval: const Duration(milliseconds: 100),
        callback: () {
          counter++;
        },
      );

      scheduler.start();

      // Wait for two intervals
      await Future.delayed(const Duration(milliseconds: 250));

      // Stop the timer
      scheduler.stop();

      // Record the counter value after stopping
      final stoppedCounter = counter;

      // Wait for a bit more to ensure no further callbacks occur
      await Future.delayed(const Duration(milliseconds: 250));

      // Ensure the counter hasn't increased after stopping
      expect(counter, equals(stoppedCounter));
    });

    test('Starting and stopping multiple times behaves correctly', () async {
      int counter = 0;
      final scheduler = Scheduler(
        interval: const Duration(milliseconds: 100),
        callback: () {
          counter++;
        },
      );

      // Start the scheduler, then stop it after some time
      scheduler.start();
      await Future.delayed(const Duration(milliseconds: 150));
      scheduler.stop();

      final stoppedCounter1 = counter;

      // Start the scheduler again
      scheduler.start();
      await Future.delayed(const Duration(milliseconds: 150));
      scheduler.stop();

      final stoppedCounter2 = counter;

      // Ensure the counter increased after the second start
      expect(stoppedCounter2, greaterThan(stoppedCounter1));
    });

    test('isRunning returns correct state', () {
      final scheduler = Scheduler(
        interval: const Duration(milliseconds: 100),
        callback: () {},
      );

      // Initially, it should not be running
      expect(scheduler.isRunning, isFalse);

      scheduler.start();
      // After starting, it should be running
      expect(scheduler.isRunning, isTrue);

      scheduler.stop();
      // After stopping, it should not be running
      expect(scheduler.isRunning, isFalse);
    });
  });
}
