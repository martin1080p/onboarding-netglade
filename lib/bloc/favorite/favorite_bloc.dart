import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding/bloc/favorite/favorite_event.dart';
import 'package:onboarding/bloc/favorite/favorite_state.dart';
import 'package:onboarding/enums/telemetry_column.dart';
import 'package:onboarding/helpers/helper.dart';
import 'package:onboarding/models/telemetry_model.dart';
import 'package:onboarding/repositories/telemetry_repository.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  TelemetryColumn sortColumn = TelemetryColumn.id;
  bool isAscending = false;
  DateTime startDate = DateTime(2000);
  DateTime endDate = DateTime.now();
  List<TelemetryModel> telemetries = [];
  bool isLoading = false;
  String errorMessage = '';
  int selectedTelemetryId = -1;

  FavoriteBloc() : super(FavoriteState()) {
    on<SetDateRange>(onSetDateRange);
    on<FetchFavorites>(onFetchFavorites);
    on<SelectFavorite>(onSelectFavorite);
    on<SortFavorite>(onSortFavorite);
    on<UnlikeTelemetry>(onUnlikeTelemetry);
  }

  void onUnlikeTelemetry(UnlikeTelemetry event, Emitter<FavoriteState> emit) async {
    emit(state.copyWith(isLoading: true, selectedTelemetryId: -1));
    try {
      await TelemetryRepository.i.unlikeTelemetry(event.telemetryId);
      final telemetries = await TelemetryRepository.i.getFavouriteTelemetries(state);
      final sortedTelemetries =
          Helper.sortTelemetries(telemetries, state.sortColumn.getValue, state.isAscending);
      emit(state.copyWith(telemetries: sortedTelemetries, isLoading: false));
    } catch (e) {
      _emitError(emit, "Failed to unlike telemetry");
    }
  }

  void onSetDateRange(SetDateRange event, Emitter<FavoriteState> emit) {
    emit(state.copyWith(startDate: event.startDate, endDate: event.endDate));

    add(FetchFavorites(
        sortColumn: state.sortColumn,
        isAscending: state.isAscending,
        startDate: event.startDate,
        endDate: event.endDate));
  }

  void onSelectFavorite(SelectFavorite event, Emitter<FavoriteState> emit) {
    if (state.selectedTelemetryId == event.telemetryId) {
      emit(state.copyWith(selectedTelemetryId: -1));
      return;
    }
    emit(state.copyWith(selectedTelemetryId: event.telemetryId));
  }

  void onSortFavorite(SortFavorite event, Emitter<FavoriteState> emit) {
    final sortedTelemetries =
        Helper.sortTelemetries(event.telemetries, event.sortColumn.getValue, event.isAscending);
    emit(state.copyWith(
        telemetries: sortedTelemetries,
        sortColumn: event.sortColumn,
        isAscending: event.isAscending));
  }

  void onFetchFavorites(FetchFavorites event, Emitter<FavoriteState> emit) async {
    emit(state.copyWith(
        sortColumn: event.sortColumn,
        isAscending: event.isAscending,
        startDate: event.startDate,
        endDate: event.endDate,
        isLoading: true));

    try {
      final telemetries = await TelemetryRepository.i.getFavouriteTelemetries(state);
      final sortedTelemetries =
          Helper.sortTelemetries(telemetries, state.sortColumn.getValue, state.isAscending);
      emit(state.copyWith(telemetries: sortedTelemetries, isLoading: false));
    } catch (e) {
      _emitError(emit, "Failed to fetch favourite telemetries");
    }
  }

  void _emitError(Emitter<FavoriteState> emit, String e) {
    emit(state.copyWith(errorMessage: e, isLoading: false));
    emit(state.copyWith(errorMessage: ''));
  }
}
