import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  final String username;
  final String usernameError;
  final String email;
  final String emailError;
  final String password;
  final String passwordError;
  final bool isAdmin;
  final bool isSubmitting;
  final bool isPasswordVisible;
  final String errorMessage;

  const RegisterState({
    this.username = '',
    this.usernameError = '',
    this.email = '',
    this.emailError = '',
    this.password = '',
    this.passwordError = '',
    this.isAdmin = false,
    this.isSubmitting = false,
    this.isPasswordVisible = false,
    this.errorMessage = '',
  });

  bool get isValid =>
      username.isNotEmpty &&
      email.isNotEmpty &&
      password.isNotEmpty &&
      usernameError.isEmpty &&
      emailError.isEmpty &&
      passwordError.isEmpty;

  RegisterState copyWith({
    String? username,
    String? usernameError,
    String? password,
    String? passwordError,
    String? email,
    String? emailError,
    bool? isAdmin,
    bool? isSubmitting,
    bool? isPasswordVisible,
    String? errorMessage,
  }) {
    return RegisterState(
      username: username ?? this.username,
      usernameError: usernameError ?? this.usernameError,
      password: password ?? this.password,
      passwordError: passwordError ?? this.passwordError,
      email: email ?? this.email,
      emailError: emailError ?? this.emailError,
      isAdmin: isAdmin ?? this.isAdmin,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        username,
        usernameError,
        email,
        emailError,
        password,
        passwordError,
        isAdmin,
        isSubmitting,
        isPasswordVisible,
        errorMessage
      ];
}
