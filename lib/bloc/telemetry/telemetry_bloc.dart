import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding/bloc/telemetry/telemetry_event.dart';
import 'package:onboarding/bloc/telemetry/telemetry_state.dart';
import 'package:onboarding/models/telemetry_model.dart';

class TelemetryBloc extends Bloc<TelemetryEvent, TelemetryState> {
  String sortProp = 'timestamp';
  bool isAscending = true;
  int startTimestamp = 0;
  int endTimestamp = 4611686018427388000;
  int minAltitudeFilter = 0;
  int maxAltitudeFilter = 4611686018427388000;
  int page = 1;
  int pageSize = 10;
  bool isLoading = false;
  String errorMessage = '';
  List<TelemetryModel> telemetries = [];

  TelemetryBloc() : super(const TelemetryState()) {
    on<FetchTelemetry>(onFetchTelemetry);
    on<SortTelemetry>(onSortTelemetry);
    on<FilterTelemetry>(onFilterTelemetry);
  }

  void onFetchTelemetry(FetchTelemetry event, Emitter<TelemetryState> emit) async {}

  void onSortTelemetry(SortTelemetry event, Emitter<TelemetryState> emit) async {
    emit(state.copyWith(sortProp: event.sortProp, isAscending: event.isAscending));
  }

  void onFilterTelemetry(FilterTelemetry event, Emitter<TelemetryState> emit) async {}
}
