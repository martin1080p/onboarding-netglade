import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final String username;
  final String usernameError;
  final String password;
  final String passwordError;
  final bool isSubmitting;
  final bool isPasswordVisible;
  final String errorMessage;

  const LoginState({
    this.username = '',
    this.usernameError = '',
    this.password = '',
    this.passwordError = '',
    this.isSubmitting = false,
    this.isPasswordVisible = false,
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
    bool? isPasswordVisible,
    String? errorMessage,
  }) {
    return LoginState(
      username: username ?? this.username,
      usernameError: usernameError ?? this.usernameError,
      password: password ?? this.password,
      passwordError: passwordError ?? this.passwordError,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
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
        isPasswordVisible,
        errorMessage,
      ];
}
