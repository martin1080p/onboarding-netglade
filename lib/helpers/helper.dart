import 'package:flutter/material.dart';
import 'package:onboarding/models/telemetry_model.dart';

class Helper {
  static List<TelemetryModel> sortTelemetries(List<TelemetryModel> telemetries,
      dynamic Function(TelemetryModel) getValue, bool isAscending) {
    if (isAscending) {
      telemetries.sort((a, b) => getValue(a) > getValue(b) ? 1 : -1);
    } else {
      telemetries.sort((a, b) => getValue(a) < getValue(b) ? 1 : -1);
    }
    return telemetries;
  }

  static int timestampFromDate(DateTime date, {bool isEndOfDay = false}) {
    if (isEndOfDay) {
      return (DateTime(date.year, date.month, date.day, 23, 59, 59).millisecondsSinceEpoch / 1000)
          .floor();
    }
    return (DateTime(date.year, date.month, date.day).millisecondsSinceEpoch / 1000).floor();
  }

  static Future<void> selectDate({
    required BuildContext context,
    required Function(DateTime startDate, DateTime endDate) onDateRangeSelected,
  }) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (context.mounted && picked != null) {
      onDateRangeSelected(picked.start, picked.end);
    }
  }
}
