import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding/bloc/error/error_event.dart';
import 'package:onboarding/bloc/error/error_state.dart';
import 'package:onboarding/models/error_model.dart';
import 'package:onboarding/repositories/error_repository.dart';

class ErrorBloc extends Bloc<ErrorEvent, ErrorState> {
  final int page = 0;
  final int pageSize = 10;
  final bool isLoading = true;
  final String errorMessage = '';
  final List<ErrorModel> errors = [];
  final int selectedErrorId = -1;
  final bool hasReachedMax = false;

  ErrorBloc() : super(const ErrorState()) {
    on<FetchError>(onFetchErrors);
    on<SelectError>(onSelectError);
    on<DeleteError>(onDeleteError);
  }

  void onFetchErrors(FetchError event, Emitter<ErrorState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final errors = await ErrorRepository.i.getErrors(state);
      emit(state.copyWith(errors: errors, isLoading: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }

  void onSelectError(SelectError event, Emitter<ErrorState> emit) {
    emit(state.copyWith(selectedErrorId: event.errorId));
  }

  void onDeleteError(DeleteError event, Emitter<ErrorState> emit) async {
    emit(state.copyWith(errors: [], isLoading: true));
    try {
      await ErrorRepository.i.deleteError(event.errorId);
      final errors = await ErrorRepository.i.getErrors(state);
      emit(state.copyWith(errors: errors));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }
}
