class RegisterEvent {}

class RegisterUsernameChanged extends RegisterEvent {
  final String username;
  RegisterUsernameChanged({required this.username});
}

class RegisterEmailChanged extends RegisterEvent {
  final String email;
  RegisterEmailChanged({required this.email});
}

class RegisterPasswordChanged extends RegisterEvent {
  final String password;
  RegisterPasswordChanged({required this.password});
}

class RegisterSubmited extends RegisterEvent {}

class RegisterAdminChanged extends RegisterEvent {
  final bool isAdmin;
  RegisterAdminChanged({required this.isAdmin});
}

class RegisterPasswordVisibilityChanged extends RegisterEvent {}
