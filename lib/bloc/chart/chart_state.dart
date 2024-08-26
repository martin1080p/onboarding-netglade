import 'package:equatable/equatable.dart';
import 'package:onboarding/models/telemetry_model.dart';

class ChartState extends Equatable {
  final bool isLoading;
  final bool isRefreshing;
  final String errorMessage;
  final int pageSize;
  final List<TelemetryModel> telemetries;

  const ChartState({
    this.isLoading = true,
    this.isRefreshing = false,
    this.errorMessage = '',
    this.pageSize = 30,
    this.telemetries = const [],
  });

  ChartState copyWith({
    bool? isLoading,
    bool? isRefreshing,
    String? errorMessage,
    int? pageSize,
    List<TelemetryModel>? telemetries,
  }) {
    return ChartState(
      isLoading: isLoading ?? this.isLoading,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      errorMessage: errorMessage ?? this.errorMessage,
      pageSize: pageSize ?? this.pageSize,
      telemetries: telemetries ?? this.telemetries,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        isRefreshing,
        errorMessage,
        pageSize,
        telemetries,
      ];
}
