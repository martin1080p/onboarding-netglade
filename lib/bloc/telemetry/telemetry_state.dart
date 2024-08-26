import 'package:equatable/equatable.dart';
import 'package:onboarding/enums/telemetry_column.dart';
import 'package:onboarding/models/telemetry_model.dart';

class TelemetryState extends Equatable {
  final TelemetryColumn sortColumn;
  final bool isAscending;
  final DateTime startDate;
  final DateTime endDate;
  final int minAltitudeFilter;
  final int maxAltitudeFilter;
  final int page;
  final int pageSize;
  final bool isLoading;
  final bool isRefreshing;
  final String errorMessage;
  final List<TelemetryModel> telemetries;
  final int selectedTelemetryId;
  final bool hasReachedMax;

  TelemetryState({
    this.sortColumn = TelemetryColumn.id,
    this.isAscending = false,
    DateTime? startDate,
    DateTime? endDate,
    this.minAltitudeFilter = 0,
    this.maxAltitudeFilter = 4611686018427388000,
    this.page = 0,
    this.pageSize = 10,
    this.isLoading = true,
    this.isRefreshing = false,
    this.errorMessage = '',
    this.telemetries = const [],
    this.selectedTelemetryId = -1,
    this.hasReachedMax = false,
  })  : startDate = startDate ?? DateTime.now(),
        endDate = endDate ?? DateTime.now();

  TelemetryState copyWith({
    TelemetryColumn? sortColumn,
    bool? isAscending,
    DateTime? startDate,
    DateTime? endDate,
    int? minAltitudeFilter,
    int? maxAltitudeFilter,
    int? page,
    int? pageSize,
    bool? isLoading,
    bool? isRefreshing,
    String? errorMessage,
    List<TelemetryModel>? telemetries,
    int? selectedTelemetryId,
    bool? hasReachedMax,
  }) {
    return TelemetryState(
      sortColumn: sortColumn ?? this.sortColumn,
      isAscending: isAscending ?? this.isAscending,
      startDate: startDate,
      endDate: endDate,
      minAltitudeFilter: minAltitudeFilter ?? this.minAltitudeFilter,
      maxAltitudeFilter: maxAltitudeFilter ?? this.maxAltitudeFilter,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      isLoading: isLoading ?? this.isLoading,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      errorMessage: errorMessage ?? this.errorMessage,
      telemetries: telemetries ?? this.telemetries,
      selectedTelemetryId: selectedTelemetryId ?? this.selectedTelemetryId,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [
        sortColumn,
        isAscending,
        startDate,
        endDate,
        minAltitudeFilter,
        maxAltitudeFilter,
        page,
        pageSize,
        isLoading,
        isRefreshing,
        errorMessage,
        telemetries,
        selectedTelemetryId,
        hasReachedMax,
      ];
}
