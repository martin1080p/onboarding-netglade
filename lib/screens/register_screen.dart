import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding/bloc/register/register_bloc.dart';
import 'package:onboarding/bloc/register/register_event.dart';
import 'package:onboarding/bloc/register/register_state.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterBloc>(
      create: (context) => RegisterBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
        ),
        body: BlocBuilder<RegisterBloc, RegisterState>(
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
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        errorText: state.passwordError.isEmpty ? null : state.passwordError,
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
            );
          },
        ),
      ),
    );
  }
}
