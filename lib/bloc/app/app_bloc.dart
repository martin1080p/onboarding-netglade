import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding/bloc/app/app_event.dart';
import 'package:onboarding/bloc/app/app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  static final AppBloc i = AppBloc();

  AppBloc() : super(const AppState()) {
    on<Logout>(onLogout);
    on<Login>(onLogin);
  }

  void onLogout(Logout event, Emitter<AppState> emit) {
    emit(state.copyWith(isLoggedIn: false, hasSessionExpired: event.hasSessionExpired));
  }

  void onLogin(Login event, Emitter<AppState> emit) {
    emit(state.copyWith(isLoggedIn: true));
  }
}
