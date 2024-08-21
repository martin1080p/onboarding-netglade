class TelemetryEvent {}

class FetchTelemetry extends TelemetryEvent {
  FetchTelemetry();
}

class SortTelemetry extends TelemetryEvent {
  final String sortProp;
  final bool isAscending;

  SortTelemetry({required this.sortProp, required this.isAscending});
}

class FilterTelemetry extends TelemetryEvent {
  FilterTelemetry();
}
