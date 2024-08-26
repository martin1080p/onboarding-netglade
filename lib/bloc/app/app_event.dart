class AppEvent {}

class Login extends AppEvent {}

class Logout extends AppEvent {
  final bool hasSessionExpired;

  Logout({required this.hasSessionExpired});
}
