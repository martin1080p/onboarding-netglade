import 'package:onboarding/enums/telemetry_column.dart';
import 'package:onboarding/models/telemetry_model.dart';

class TelemetryEvent {}

class FetchTelemetry extends TelemetryEvent {
  final TelemetryColumn sortColumn;
  final bool isAscending;

  FetchTelemetry({required this.sortColumn, required this.isAscending});
}

class SortTelemetry extends TelemetryEvent {
  final TelemetryColumn sortColumn;
  final bool isAscending;
  final List<TelemetryModel> telemetries;

  SortTelemetry({required this.sortColumn, required this.isAscending, required this.telemetries});
}

class FilterTelemetry extends TelemetryEvent {}
