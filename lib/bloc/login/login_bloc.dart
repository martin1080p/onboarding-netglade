import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding/bloc/login/login_event.dart';
import 'package:onboarding/bloc/login/login_state.dart';
import 'package:onboarding/repositories/auth_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  String username = '';
  String usernameError = '';
  String password = '';
  String passwordError = '';
  bool isSubmitting = false;
  bool isSuccess = false;
  String errorMessage = '';

  LoginBloc() : super(const LoginState()) {
    on<LoginUsernameChanged>(onUsernameChanged);
    on<LoginPasswordChanged>(onPasswordChanged);
    on<LoginSubmited>(onSubmited);
  }

  void onUsernameChanged(LoginUsernameChanged event, Emitter<LoginState> emit) async {
    if (event.username.isEmpty) {
      emit(state.copyWith(username: event.username, usernameError: 'Username is required'));
      return;
    }
    emit(state.copyWith(username: event.username, usernameError: ''));
  }

  void onPasswordChanged(LoginPasswordChanged event, Emitter<LoginState> emit) async {
    if (event.password.isEmpty) {
      emit(state.copyWith(password: event.password, passwordError: 'Password is required'));
      return;
    }
    emit(state.copyWith(password: event.password, passwordError: ''));
  }

  void onSubmited(LoginSubmited event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isSubmitting: true));
    try {
      await AuthRepository.i.login(state.username, state.password);
      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(isSubmitting: false, isSuccess: false, errorMessage: e.toString()));
      emit(state.copyWith(errorMessage: ''));
    }
  }
}
