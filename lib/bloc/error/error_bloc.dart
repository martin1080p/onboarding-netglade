import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding/bloc/error/error_event.dart';
import 'package:onboarding/bloc/error/error_state.dart';
import 'package:onboarding/repositories/error_repository.dart';
import 'package:onboarding/schedulers/scheduler.dart';

class ErrorBloc extends Bloc<ErrorEvent, ErrorState> {
  late final Scheduler scheduler;

  ErrorBloc() : super(const ErrorState()) {
    on<FetchError>(onFetchErrors);
    on<SelectError>(onSelectError);
    on<DeleteError>(onDeleteError);
    on<RefreshError>(onRefreshError);

    scheduler = Scheduler(
        interval: const Duration(minutes: 1),
        callback: () {
          add(RefreshError());
        });

    scheduler.start();
  }

  @override
  Future<void> close() {
    scheduler.stop();
    return super.close();
  }

  void onRefreshError(RefreshError event, Emitter<ErrorState> emit) async {
    emit(state.copyWith(isRefreshing: true));
    try {
      final newErrors = await ErrorRepository.i.getNewErrors(state);
      emit(state.copyWith(errors: {...newErrors, ...state.errors}.toList(), isRefreshing: false));
    } catch (e) {
      _emitError(emit, 'Failed to refresh errors');
    }
  }

  void onFetchErrors(FetchError event, Emitter<ErrorState> emit) async {
    emit(state.copyWith(isLoading: true, page: state.page + 1));
    try {
      final errors = await ErrorRepository.i.getErrors(state);
      emit(state.copyWith(errors: {...state.errors, ...errors}.toList(), isLoading: false));
    } catch (e) {
      _emitError(emit, 'Failed to fetch errors');
    }
  }

  void onSelectError(SelectError event, Emitter<ErrorState> emit) {
    emit(state.copyWith(selectedErrorId: event.errorId));
  }

  void onDeleteError(DeleteError event, Emitter<ErrorState> emit) async {
    emit(state.copyWith(errors: [], isLoading: true, selectedErrorId: -1));
    try {
      await ErrorRepository.i.deleteError(event.errorId);
      emit(state.copyWith(page: 1));
      final errors = await ErrorRepository.i.getErrors(state);
      emit(state.copyWith(errors: errors));
    } catch (e) {
      _emitError(emit, 'Failed to delete error');
    }
  }

  void _emitError(Emitter<ErrorState> emit, String e) {
    emit(state.copyWith(errorMessage: e, isLoading: false, isRefreshing: false));
    emit(state.copyWith(errorMessage: ''));
  }
}
