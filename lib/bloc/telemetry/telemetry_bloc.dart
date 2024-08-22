import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding/bloc/telemetry/telemetry_event.dart';
import 'package:onboarding/bloc/telemetry/telemetry_state.dart';
import 'package:onboarding/enums/telemetry_column.dart';
import 'package:onboarding/helpers/helper.dart';
import 'package:onboarding/models/telemetry_model.dart';
import 'package:onboarding/repositories/telemetry_repository.dart';

class TelemetryBloc extends Bloc<TelemetryEvent, TelemetryState> {
  TelemetryColumn sortColumn = TelemetryColumn.id;
  bool isAscending = false;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  int minAltitudeFilter = 0;
  int maxAltitudeFilter = 4611686018427388000;
  int page = 0;
  int pageSize = 10;
  bool isLoading = true;
  String errorMessage = '';
  List<TelemetryModel> telemetries = [];
  int selectedTelemetryId = -1;
  bool hasReachedMax = false;

  TelemetryBloc() : super(TelemetryState()) {
    on<FetchTelemetry>(onFetchTelemetry);
    on<SortTelemetry>(onSortTelemetry);
    on<FilterTelemetry>(onFilterTelemetry);
    on<SelectTelemetry>(onSelectTelemetry);
    on<DeleteTelemetry>(onDeleteTelemetry);
    on<LikeTelemetry>(onLikeTelemetry);
    on<SetDateRange>(onSetDateRange);
  }

  void onDeleteTelemetry(DeleteTelemetry event, Emitter<TelemetryState> emit) async {
    emit(state.copyWith(selectedTelemetryId: -1, telemetries: [], isLoading: true));
    try {
      await TelemetryRepository.i.deleteTelemetry(event.telemetryId);
      final telemetries = await TelemetryRepository.i.getTelemetries(state);
      final sortedTelemetries =
          Helper.sortTelemetries(telemetries, state.sortColumn.getValue, state.isAscending);
      emit(state.copyWith(
          telemetries: sortedTelemetries,
          isLoading: false,
          hasReachedMax: telemetries.length < state.pageSize));
    } catch (e) {
      _emitError(emit, "Failed to delete telemetry");
    }
  }

  void onLikeTelemetry(LikeTelemetry event, Emitter<TelemetryState> emit) async {
    try {
      await TelemetryRepository.i.likeTelemetry(event.telemetryId);
      emit(state.copyWith(selectedTelemetryId: -1));
    } catch (e) {
      _emitError(emit, "Telemetry already added to favourites");
    }
  }

  void onSelectTelemetry(SelectTelemetry event, Emitter<TelemetryState> emit) {
    if (state.selectedTelemetryId == event.telemetryId) {
      emit(state.copyWith(selectedTelemetryId: -1));
      return;
    }
    emit(state.copyWith(selectedTelemetryId: event.telemetryId));
  }

  void onFetchTelemetry(FetchTelemetry event, Emitter<TelemetryState> emit) async {
    emit(state.copyWith(
        isLoading: true,
        errorMessage: '',
        page: state.page + 1,
        startDate: state.startDate,
        endDate: state.endDate));
    try {
      final telemetries = await TelemetryRepository.i.getTelemetries(state);
      final sortedTelemetries = Helper.sortTelemetries(
          {...telemetries, ...state.telemetries}.toList(),
          event.sortColumn.getValue,
          event.isAscending);
      emit(state.copyWith(
          telemetries: sortedTelemetries,
          isLoading: false,
          startDate: state.startDate,
          endDate: state.endDate,
          hasReachedMax: telemetries.length < state.pageSize));
    } catch (e) {
      _emitError(emit, "Failed to fetch telemetries");
    }
  }

  void onSortTelemetry(SortTelemetry event, Emitter<TelemetryState> emit) async {
    final sortedTelemetries =
        Helper.sortTelemetries(event.telemetries, event.sortColumn.getValue, event.isAscending);

    emit(state.copyWith(
        sortColumn: event.sortColumn,
        isAscending: event.isAscending,
        telemetries: sortedTelemetries));
  }

  void onSetDateRange(SetDateRange event, Emitter<TelemetryState> emit) async {
    emit(state.copyWith(
      startDate: event.startDate,
      endDate: event.endDate,
    ));
  }

  void onFilterTelemetry(FilterTelemetry event, Emitter<TelemetryState> emit) async {
    emit(state.copyWith(
      minAltitudeFilter: event.minAltitude ?? 0,
      maxAltitudeFilter: event.maxAltitude ?? 4611686018427388000,
      startDate: state.startDate,
      endDate: state.endDate,
      isLoading: true,
      page: 1,
      selectedTelemetryId: -1,
    ));
    try {
      final telemetries = await TelemetryRepository.i.getTelemetries(state);
      final sortedTelemetries =
          Helper.sortTelemetries(telemetries, state.sortColumn.getValue, state.isAscending);
      emit(state.copyWith(
          telemetries: sortedTelemetries,
          isLoading: false,
          startDate: state.startDate,
          endDate: state.endDate,
          hasReachedMax: telemetries.length < state.pageSize));
    } catch (e) {
      _emitError(emit, "Failed to filter telemetries");
    }
  }

  void _emitError(Emitter<TelemetryState> emit, String e) {
    emit(state.copyWith(errorMessage: e, isLoading: false));
    emit(state.copyWith(errorMessage: ''));
  }
}
