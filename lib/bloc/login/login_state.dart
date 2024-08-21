import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final String username;
  final String usernameError;
  final String password;
  final String passwordError;
  final bool isSubmitting;
  final bool isSuccess;
  final String errorMessage;

  const LoginState({
    this.username = '',
    this.usernameError = '',
    this.password = '',
    this.passwordError = '',
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage = '',
  });

  bool get isValid =>
      username.isNotEmpty && password.isNotEmpty && usernameError.isEmpty && passwordError.isEmpty;

  LoginState copyWith({
    String? username,
    String? usernameError,
    String? password,
    String? passwordError,
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return LoginState(
      username: username ?? this.username,
      usernameError: usernameError ?? this.usernameError,
      password: password ?? this.password,
      passwordError: passwordError ?? this.passwordError,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        username,
        usernameError,
        password,
        passwordError,
        isSubmitting,
        isSuccess,
        errorMessage,
      ];
}
