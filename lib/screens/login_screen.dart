import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding/bloc/login/login_bloc.dart';
import 'package:onboarding/bloc/login/login_event.dart';
import 'package:onboarding/bloc/login/login_state.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (state.isSuccess) {
                Navigator.pushReplacementNamed(context, '/home');
              }
              if (state.errorMessage.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            });
            return Padding(
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
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        errorText: state.passwordError.isEmpty ? null : state.passwordError,
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
            );
          },
        ),
      ),
    );
  }
}
