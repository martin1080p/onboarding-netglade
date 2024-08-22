import 'package:onboarding/enums/telemetry_column.dart';
import 'package:onboarding/models/telemetry_model.dart';

class TelemetryEvent {}

class FetchTelemetry extends TelemetryEvent {
  final TelemetryColumn sortColumn;
  final bool isAscending;
  final DateTime startDate;
  final DateTime endDate;

  FetchTelemetry(
      {required this.sortColumn,
      required this.isAscending,
      required this.startDate,
      required this.endDate});
}

class SortTelemetry extends TelemetryEvent {
  final TelemetryColumn sortColumn;
  final bool isAscending;
  final List<TelemetryModel> telemetries;

  SortTelemetry({required this.sortColumn, required this.isAscending, required this.telemetries});
}

class FilterTelemetry extends TelemetryEvent {
  final int? minAltitude;
  final int? maxAltitude;
  FilterTelemetry({required this.minAltitude, required this.maxAltitude});
}

class SetDateRange extends TelemetryEvent {
  final DateTime startDate;
  final DateTime endDate;

  SetDateRange({required this.startDate, required this.endDate});
}

class SelectTelemetry extends TelemetryEvent {
  final int telemetryId;

  SelectTelemetry({required this.telemetryId});
}

class DeleteTelemetry extends TelemetryEvent {
  final int telemetryId;

  DeleteTelemetry({required this.telemetryId});
}

class LikeTelemetry extends TelemetryEvent {
  final int telemetryId;

  LikeTelemetry({required this.telemetryId});
}
