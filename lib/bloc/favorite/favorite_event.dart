import 'package:onboarding/enums/telemetry_column.dart';
import 'package:onboarding/models/telemetry_model.dart';

class FavoriteEvent {}

class SetDateRange extends FavoriteEvent {
  final DateTime startDate;
  final DateTime endDate;

  SetDateRange({required this.startDate, required this.endDate});
}

class FetchFavorites extends FavoriteEvent {
  final TelemetryColumn sortColumn;
  final bool isAscending;
  final DateTime startDate;
  final DateTime endDate;

  FetchFavorites(
      {required this.sortColumn,
      required this.isAscending,
      required this.startDate,
      required this.endDate});
}

class SortFavorite extends FavoriteEvent {
  final List<TelemetryModel> telemetries;
  final TelemetryColumn sortColumn;
  final bool isAscending;

  SortFavorite({required this.telemetries, required this.sortColumn, required this.isAscending});
}

class SelectFavorite extends FavoriteEvent {
  final int telemetryId;

  SelectFavorite({required this.telemetryId});
}

class UnlikeTelemetry extends FavoriteEvent {
  final int telemetryId;

  UnlikeTelemetry({required this.telemetryId});
}
