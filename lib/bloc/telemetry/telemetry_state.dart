import 'package:equatable/equatable.dart';
import 'package:onboarding/enums/telemetry_column.dart';
import 'package:onboarding/models/telemetry_model.dart';

class TelemetryState extends Equatable {
  final TelemetryColumn sortColumn;
  final bool isAscending;
  final int startTimestamp;
  final int endTimestamp;
  final int minAltitudeFilter;
  final int maxAltitudeFilter;
  final int page;
  final int pageSize;
  final bool isLoading;
  final String errorMessage;
  final List<TelemetryModel> telemetries;

  const TelemetryState({
    this.sortColumn = TelemetryColumn.id,
    this.isAscending = false,
    this.startTimestamp = 0,
    this.endTimestamp = 4611686018427388000,
    this.minAltitudeFilter = 0,
    this.maxAltitudeFilter = 4611686018427388000,
    this.page = 1,
    this.pageSize = 10,
    this.isLoading = true,
    this.errorMessage = '',
    this.telemetries = const [],
  });

  TelemetryState copyWith({
    TelemetryColumn? sortColumn,
    bool? isAscending,
    int? startTimestamp,
    int? endTimestamp,
    int? minAltitudeFilter,
    int? maxAltitudeFilter,
    int? page,
    int? pageSize,
    bool? isLoading,
    String? errorMessage,
    List<TelemetryModel>? telemetries,
  }) {
    return TelemetryState(
      sortColumn: sortColumn ?? this.sortColumn,
      isAscending: isAscending ?? this.isAscending,
      startTimestamp: startTimestamp ?? this.startTimestamp,
      endTimestamp: endTimestamp ?? this.endTimestamp,
      minAltitudeFilter: minAltitudeFilter ?? this.minAltitudeFilter,
      maxAltitudeFilter: maxAltitudeFilter ?? this.maxAltitudeFilter,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      telemetries: telemetries ?? this.telemetries,
    );
  }

  @override
  List<Object> get props => [
        sortColumn,
        isAscending,
        startTimestamp,
        endTimestamp,
        minAltitudeFilter,
        maxAltitudeFilter,
        page,
        pageSize,
        isLoading,
        errorMessage,
        telemetries,
      ];
}
