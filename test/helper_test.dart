import 'package:flutter_test/flutter_test.dart';
import 'package:onboarding/enums/telemetry_column.dart';
import 'package:onboarding/enums/user_column.dart';
import 'package:onboarding/helpers/helper.dart';
import 'package:onboarding/models/telemetry_model.dart';
import 'package:onboarding/models/user_model.dart';

void main() {
  group('Helper', () {
    test('sortTelemetries sorts in ascending order', () {
      final telemetries = [
        TelemetryModel.empty().copyWith(altitude: 5),
        TelemetryModel.empty().copyWith(altitude: 2),
        TelemetryModel.empty().copyWith(altitude: 8),
      ];

      final sorted = Helper.sortTelemetries(
        telemetries,
        TelemetryColumn.altitude.getValue,
        true,
      );

      expect(sorted[0].altitude, equals(2));
      expect(sorted[1].altitude, equals(5));
      expect(sorted[2].altitude, equals(8));
    });

    test('sortTelemetries sorts in descending order', () {
      final telemetries = [
        TelemetryModel.empty().copyWith(altitude: 5),
        TelemetryModel.empty().copyWith(altitude: 2),
        TelemetryModel.empty().copyWith(altitude: 8),
      ];

      final sorted = Helper.sortTelemetries(
        telemetries,
        TelemetryColumn.altitude.getValue,
        false,
      );

      expect(sorted[0].altitude, equals(8));
      expect(sorted[1].altitude, equals(5));
      expect(sorted[2].altitude, equals(2));
    });

    test('sortUsers sorts Comparable values correctly', () {
      final users = [
        UserModel.empty().copyWith(name: 'Charlie'),
        UserModel.empty().copyWith(name: 'Alice'),
        UserModel.empty().copyWith(name: 'Bob'),
      ];

      final sorted = Helper.sortUsers(
        users,
        UserColumn.username.getValue,
        true,
      );

      expect(sorted[0].name, equals('Alice'));
      expect(sorted[1].name, equals('Bob'));
      expect(sorted[2].name, equals('Charlie'));
    });

    test('sortUsers handles boolean values correctly', () {
      final users = [
        UserModel.empty().copyWith(isDeleted: true),
        UserModel.empty().copyWith(isDeleted: false),
        UserModel.empty().copyWith(isDeleted: true),
        UserModel.empty().copyWith(isDeleted: false),
      ];

      final sorted = Helper.sortUsers(
        users,
        UserColumn.isDeleted.getValue,
        true,
      );

      expect(sorted[0].isDeleted, isFalse);
      expect(sorted[1].isDeleted, isFalse);
      expect(sorted[2].isDeleted, isTrue);
      expect(sorted[2].isDeleted, isTrue);
    });

    test('timestampFromDate returns correct timestamp', () {
      final date = DateTime(2024, 8, 26);

      final startTimestamp = Helper.timestampFromDate(date);
      final endTimestamp = Helper.timestampFromDate(date, isEndOfDay: true);

      expect(startTimestamp, equals(1724623200));
      expect(endTimestamp, equals(1724709599));
    });
  });
}
