import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding/bloc/chart/chart_event.dart';
import 'package:onboarding/bloc/chart/chart_state.dart';
import 'package:onboarding/enums/telemetry_column.dart';
import 'package:onboarding/helpers/helper.dart';
import 'package:onboarding/repositories/telemetry_repository.dart';
import 'package:onboarding/schedulers/scheduler.dart';

class ChartBloc extends Bloc<ChartEvent, ChartState> {
  late final Scheduler scheduler;

  ChartBloc() : super(const ChartState()) {
    on<FetchChart>(onFetchChart);
    on<RefreshChart>(onRefreshChart);

    scheduler = Scheduler(
        interval: const Duration(seconds: 10),
        callback: () {
          add(RefreshChart());
        });

    scheduler.start();
  }

  @override
  Future<void> close() {
    scheduler.stop();
    return super.close();
  }

  void onFetchChart(FetchChart event, Emitter<ChartState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final telemetries = await TelemetryRepository.i.getNewTelemetries(
        startDate: DateTime.now().subtract(const Duration(minutes: 1)),
        endDate: DateTime.now().add(const Duration(minutes: 1)),
        pageSize: state.pageSize,
      );

      final sortedTelemetries =
          Helper.sortTelemetries(telemetries, TelemetryColumn.timestamp.getValue, false);
      emit(state.copyWith(telemetries: sortedTelemetries, isLoading: false));
    } catch (e) {
      _emitError(emit, 'Failed to fetch telemetries');
    }
  }

  void onRefreshChart(RefreshChart event, Emitter<ChartState> emit) async {
    emit(state.copyWith(isRefreshing: true));
    try {
      final telemetries = await TelemetryRepository.i.getNewTelemetries(
        startDate: DateTime.now().subtract(const Duration(minutes: 1)),
        endDate: DateTime.now().add(const Duration(minutes: 1)),
        pageSize: state.pageSize,
      );

      final sortedTelemetries =
          Helper.sortTelemetries(telemetries, TelemetryColumn.timestamp.getValue, false);
      emit(state.copyWith(telemetries: sortedTelemetries, isRefreshing: false));
    } catch (e) {
      _emitError(emit, 'Failed to fetch telemetries');
    }
  }

  void _emitError(Emitter<ChartState> emit, String e) {
    emit(state.copyWith(errorMessage: e, isLoading: false, isRefreshing: false));
    emit(state.copyWith(errorMessage: ''));
  }
}
