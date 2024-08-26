import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding/bloc/app/app_bloc.dart';
import 'package:onboarding/bloc/app/app_event.dart';
import 'package:onboarding/bloc/register/register_event.dart';
import 'package:onboarding/bloc/register/register_state.dart';
import 'package:onboarding/repositories/auth_repository.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterState()) {
    on<RegisterUsernameChanged>(onUsernameChanged);
    on<RegisterEmailChanged>(onEmailChanged);
    on<RegisterPasswordChanged>(onPasswordChanged);
    on<RegisterAdminChanged>(onAdminChanged);
    on<RegisterSubmited>(onSubmited);
    on<RegisterPasswordVisibilityChanged>(onPasswordVisibilityChanged);
  }

  void onPasswordVisibilityChanged(
      RegisterPasswordVisibilityChanged event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void onUsernameChanged(RegisterUsernameChanged event, Emitter<RegisterState> emit) async {
    final username = event.username;
    if (username.isEmpty) {
      emit(state.copyWith(username: username, usernameError: 'Username must not be empty'));
      return;
    }
    emit(state.copyWith(username: username, usernameError: ''));
  }

  void onEmailChanged(RegisterEmailChanged event, Emitter<RegisterState> emit) async {
    final email = event.email;
    if (email.isEmpty) {
      emit(state.copyWith(email: email, emailError: 'Email must not be empty'));
      return;
    }
    emit(state.copyWith(email: email, emailError: ''));
  }

  void onPasswordChanged(RegisterPasswordChanged event, Emitter<RegisterState> emit) async {
    final password = event.password;
    if (password.isEmpty) {
      emit(state.copyWith(password: password, passwordError: 'Password must not be empty'));
      return;
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      emit(state.copyWith(password: password, passwordError: 'Password must contain uppercase'));
      return;
    }
    if (!password.contains(RegExp(r'\d'))) {
      emit(state.copyWith(password: password, passwordError: 'Password must contain number'));
      return;
    }
    if (!password.contains(RegExp(r'''[$*.[\]{}()?\-"'!@#%&/\\,><:;_~`+=]'''))) {
      emit(state.copyWith(
          password: password, passwordError: 'Password must contain special character'));
      return;
    }
    if (password.length < 6) {
      emit(state.copyWith(password: password, passwordError: 'Password is too short'));
      return;
    }

    emit(state.copyWith(password: password, passwordError: ''));
  }

  void onAdminChanged(RegisterAdminChanged event, Emitter<RegisterState> emit) async {
    final isAdmin = event.isAdmin;
    emit(state.copyWith(isAdmin: isAdmin));
  }

  void onSubmited(RegisterSubmited event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(isSubmitting: true));
    try {
      if (state.isAdmin) {
        await AuthRepository.i.registerAdmin(state.username, state.email, state.password);
      } else {
        await AuthRepository.i.register(state.username, state.email, state.password);
      }
      AppBloc.i.add(Login());
    } catch (e) {
      emit(state.copyWith(
        isSubmitting: false,
        errorMessage: 'Failed to Register',
      ));
      emit(state.copyWith(errorMessage: ''));
    }
  }
}
