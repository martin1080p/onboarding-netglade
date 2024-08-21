import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding/bloc/register/register_event.dart';
import 'package:onboarding/bloc/register/register_state.dart';
import 'package:onboarding/repositories/auth_repository.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  String username = '';
  String usernameError = '';
  String password = '';
  String passwordError = '';
  String email = '';
  String emailError = '';
  bool isAdmin = false;
  bool isSubmitting = false;
  bool isSuccess = false;
  String errorMessage = '';

  RegisterBloc() : super(const RegisterState()) {
    on<RegisterUsernameChanged>(onUsernameChanged);
    on<RegisterEmailChanged>(onEmailChanged);
    on<RegisterPasswordChanged>(onPasswordChanged);
    on<RegisterAdminChanged>(onAdminChanged);
    on<RegisterSubmited>(onSubmited);
  }

  void onUsernameChanged(RegisterUsernameChanged event, Emitter<RegisterState> emit) async {
    String username = event.username;
    if (username.isEmpty) {
      emit(state.copyWith(username: username, usernameError: 'Username must not be empty'));
      return;
    }
    emit(state.copyWith(username: username, usernameError: ''));
  }

  void onEmailChanged(RegisterEmailChanged event, Emitter<RegisterState> emit) async {
    String email = event.email;
    if (email.isEmpty) {
      emit(state.copyWith(email: email, emailError: 'Email must not be empty'));
      return;
    }
    emit(state.copyWith(email: email, emailError: ''));
  }

  void onPasswordChanged(RegisterPasswordChanged event, Emitter<RegisterState> emit) async {
    String password = event.password;
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
    bool isAdmin = event.isAdmin;
    emit(state.copyWith(isAdmin: isAdmin));
  }

  void onSubmited(RegisterSubmited event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(isSubmitting: true));
    try {
      if (isAdmin) {
        await AuthRepository.i.registerAdmin(username, email, password);
      } else {
        await AuthRepository.i.register(username, email, password);
      }
      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(
        isSubmitting: false,
        isSuccess: false,
        errorMessage: 'Failed to Register',
      ));
    }
  }
}
