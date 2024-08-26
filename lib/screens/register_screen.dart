import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding/bloc/app/app_bloc.dart';
import 'package:onboarding/bloc/app/app_state.dart';
import 'package:onboarding/bloc/register/register_bloc.dart';
import 'package:onboarding/bloc/register/register_event.dart';
import 'package:onboarding/bloc/register/register_state.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (state.isLoggedIn) {
          Navigator.of(context).pushReplacementNamed('/home');
        }
      },
      child: BlocProvider<RegisterBloc>(
        create: (context) => RegisterBloc(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Register'),
          ),
          body: BlocListener<RegisterBloc, RegisterState>(
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
            child: BlocBuilder<RegisterBloc, RegisterState>(
              builder: (context, state) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        onChanged: (username) => context
                            .read<RegisterBloc>()
                            .add(RegisterUsernameChanged(username: username)),
                        decoration: InputDecoration(
                          labelText: 'Username',
                          errorText: state.usernameError.isEmpty ? null : state.usernameError,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        onChanged: (email) =>
                            context.read<RegisterBloc>().add(RegisterEmailChanged(email: email)),
                        decoration: InputDecoration(
                          labelText: 'Email',
                          errorText: state.emailError.isEmpty ? null : state.emailError,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        onChanged: (password) => context
                            .read<RegisterBloc>()
                            .add(RegisterPasswordChanged(password: password)),
                        obscureText: !state.isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          errorText: state.passwordError.isEmpty ? null : state.passwordError,
                          suffixIcon: IconButton(
                            icon: Icon(
                                state.isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                            onPressed: () {
                              context.read<RegisterBloc>().add(RegisterPasswordVisibilityChanged());
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Admin account'),
                          Switch(
                            value: state.isAdmin,
                            onChanged: (value) {
                              context.read<RegisterBloc>().add(
                                    RegisterAdminChanged(isAdmin: value),
                                  );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      state.isSubmitting
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: state.isValid
                                  ? () {
                                      context.read<RegisterBloc>().add(RegisterSubmited());
                                    }
                                  : null,
                              child: const Text('Register'),
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
