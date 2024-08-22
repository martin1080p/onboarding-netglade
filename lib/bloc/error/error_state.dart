import 'package:equatable/equatable.dart';
import 'package:onboarding/models/error_model.dart';

class ErrorState extends Equatable {
  final int page;
  final int pageSize;
  final bool isLoading;
  final String errorMessage;
  final List<ErrorModel> errors;
  final int selectedErrorId;
  final bool hasReachedMax;

  const ErrorState({
    this.page = 0,
    this.pageSize = 10,
    this.isLoading = true,
    this.errorMessage = '',
    this.errors = const [],
    this.selectedErrorId = -1,
    this.hasReachedMax = false,
  });

  ErrorState copyWith({
    int? page,
    int? pageSize,
    bool? isLoading,
    String? errorMessage,
    List<ErrorModel>? errors,
    int? selectedErrorId,
    bool? hasReachedMax,
  }) {
    return ErrorState(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      errors: errors ?? this.errors,
      selectedErrorId: selectedErrorId ?? this.selectedErrorId,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [
        page,
        pageSize,
        isLoading,
        errorMessage,
        errors,
        selectedErrorId,
        hasReachedMax,
      ];
}
