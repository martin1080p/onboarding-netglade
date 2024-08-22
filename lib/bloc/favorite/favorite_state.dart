import 'package:equatable/equatable.dart';
import 'package:onboarding/enums/telemetry_column.dart';
import 'package:onboarding/models/telemetry_model.dart';

class FavoriteState extends Equatable {
  final TelemetryColumn sortColumn;
  final bool isAscending;
  final int selectedTelemetryId;
  final DateTime startDate;
  final DateTime endDate;
  final List<TelemetryModel> telemetries;
  final String errorMessage;
  final bool isLoading;

  FavoriteState({
    this.sortColumn = TelemetryColumn.id,
    this.isAscending = false,
    this.selectedTelemetryId = -1,
    DateTime? startDate,
    DateTime? endDate,
    this.telemetries = const [],
    this.errorMessage = '',
    this.isLoading = false,
  })  : startDate = startDate ?? DateTime(2000),
        endDate = endDate ?? DateTime.now();

  FavoriteState copyWith({
    TelemetryColumn? sortColumn,
    bool? isAscending,
    int? selectedTelemetryId,
    DateTime? startDate,
    DateTime? endDate,
    List<TelemetryModel>? telemetries,
    String? errorMessage,
    bool? isLoading,
  }) {
    return FavoriteState(
      sortColumn: sortColumn ?? this.sortColumn,
      isAscending: isAscending ?? this.isAscending,
      selectedTelemetryId: selectedTelemetryId ?? this.selectedTelemetryId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      telemetries: telemetries ?? this.telemetries,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [
        sortColumn,
        isAscending,
        selectedTelemetryId,
        startDate,
        endDate,
        telemetries,
        errorMessage,
        isLoading,
      ];
}
