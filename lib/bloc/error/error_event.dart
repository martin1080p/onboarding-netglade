class ErrorEvent {}

class FetchError extends ErrorEvent {}

class SelectError extends FetchError {
  final int errorId;

  SelectError({required this.errorId});
}

class DeleteError extends FetchError {
  final int errorId;

  DeleteError({required this.errorId});
}
