import 'package:flutter/material.dart';
import 'package:onboarding/models/user_model.dart';
import 'package:onboarding/repositories/auth_repository.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final UserModel user = AuthRepository.i.user;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 30),
        const Text(
          'Name',
          style: TextStyle(fontSize: 20),
        ),
        Text(
          user.name,
        ),
        const SizedBox(height: 10),
        const Text(
          'Email',
          style: TextStyle(fontSize: 20),
        ),
        Text(
          user.email!,
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () {
            AuthRepository.i.logout();
          },
          child: const Text('Logout'),
        )
      ],
    );
  }
}
