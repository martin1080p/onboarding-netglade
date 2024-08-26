import 'package:equatable/equatable.dart';

class AppState extends Equatable {
  final bool isLoggedIn;
  final bool hasSessionExpired;

  const AppState({
    this.isLoggedIn = false,
    this.hasSessionExpired = false,
  });

  AppState copyWith({
    bool? isLoggedIn,
    bool? hasSessionExpired,
  }) {
    return AppState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      hasSessionExpired: hasSessionExpired ?? this.hasSessionExpired,
    );
  }

  @override
  List<Object> get props => [isLoggedIn, hasSessionExpired];
}
