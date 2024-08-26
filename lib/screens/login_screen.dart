import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding/bloc/app/app_bloc.dart';
import 'package:onboarding/bloc/app/app_state.dart';
import 'package:onboarding/bloc/login/login_bloc.dart';
import 'package:onboarding/bloc/login/login_event.dart';
import 'package:onboarding/bloc/login/login_state.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (state.isLoggedIn) {
          Navigator.of(context).pushReplacementNamed('/home');
        }
      },
      child: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Login'),
          ),
          body: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state.errorMessage.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        onChanged: (username) =>
                            context.read<LoginBloc>().add(LoginUsernameChanged(username: username)),
                        decoration: InputDecoration(
                          labelText: 'Username',
                          errorText: state.usernameError.isEmpty ? null : state.usernameError,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        onChanged: (password) =>
                            context.read<LoginBloc>().add(LoginPasswordChanged(password: password)),
                        obscureText: !state.isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          errorText: state.passwordError.isEmpty ? null : state.passwordError,
                          suffixIcon: IconButton(
                            icon: Icon(
                                state.isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                            onPressed: () {
                              context.read<LoginBloc>().add(LoginPasswordVisibilityChanged());
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      state.isSubmitting
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: state.isValid
                                  ? () {
                                      context.read<LoginBloc>().add(LoginSubmited());
                                    }
                                  : null,
                              child: const Text('Login'),
                            ),
                      const SizedBox(height: 16.0),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: const Text("Don't have an account? Register here."),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
