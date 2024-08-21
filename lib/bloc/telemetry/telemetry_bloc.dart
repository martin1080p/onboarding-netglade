import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding/bloc/telemetry/telemetry_event.dart';
import 'package:onboarding/bloc/telemetry/telemetry_state.dart';
import 'package:onboarding/enums/telemetry_column.dart';
import 'package:onboarding/models/telemetry_model.dart';
import 'package:onboarding/repositories/telemetry_repository.dart';

class TelemetryBloc extends Bloc<TelemetryEvent, TelemetryState> {
  TelemetryColumn sortColumn = TelemetryColumn.id;
  bool isAscending = false;
  int startTimestamp = 0;
  int endTimestamp = 4611686018427388000;
  int minAltitudeFilter = 0;
  int maxAltitudeFilter = 4611686018427388000;
  int page = 1;
  int pageSize = 10;
  bool isLoading = true;
  String errorMessage = '';
  List<TelemetryModel> telemetries = [];

  TelemetryBloc() : super(const TelemetryState()) {
    on<FetchTelemetry>(onFetchTelemetry);
    on<SortTelemetry>(onSortTelemetry);
    on<FilterTelemetry>(onFilterTelemetry);
  }

  void onFetchTelemetry(FetchTelemetry event, Emitter<TelemetryState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));
    try {
      final telemetries = await TelemetryRepository.i.getTelemetries(state);
      final sortedTelemetries = sortTelemetries(
          [...telemetries, ...state.telemetries], event.sortColumn.getValue, event.isAscending);
      emit(state.copyWith(telemetries: sortedTelemetries, isLoading: false));
      emit(state);
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }

  void onSortTelemetry(SortTelemetry event, Emitter<TelemetryState> emit) async {
    final sortedTelemetries =
        sortTelemetries(event.telemetries, event.sortColumn.getValue, event.isAscending);

    emit(state.copyWith(
        sortColumn: event.sortColumn,
        isAscending: event.isAscending,
        telemetries: sortedTelemetries));
  }

  void onFilterTelemetry(FilterTelemetry event, Emitter<TelemetryState> emit) async {}

  List<TelemetryModel> sortTelemetries(List<TelemetryModel> telemetries,
      dynamic Function(TelemetryModel) getValue, bool isAscending) {
    if (isAscending) {
      telemetries.sort((a, b) => getValue(a) > getValue(b) ? 1 : -1);
    } else {
      telemetries.sort((a, b) => getValue(a) < getValue(b) ? 1 : -1);
    }
    return telemetries;
  }
}
