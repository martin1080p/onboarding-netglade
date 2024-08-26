import 'dart:convert';

import 'package:onboarding/api/client.dart';
import 'package:onboarding/models/user_model.dart';
import 'package:onboarding/repositories/auth_repository.dart';

class UserRepository {
  final HttpClient client;
  final AuthRepository authRepository;

  UserRepository._({required this.client, required this.authRepository});

  static final UserRepository i =
      UserRepository._(client: HttpClient.i, authRepository: AuthRepository.i);

  Future<List<UserModel>> getUsers() async {
    final response = await client.get(endpoint: '/users/get-all?userId=${authRepository.user.id}');
    List<UserModel> users =
        (jsonDecode(response.body) as List).map((e) => UserModel.fromJson(e)).toList();
    return users;
  }

  Future<void> deleteUser(String userId) async {
    await client.delete(
        endpoint: '/users/$userId?userId=$userId&adminId=${authRepository.user.id}');
  }

  Future<void> reinstateUser(String userId) async {
    await client.post(endpoint: '/users/$userId?userId=$userId');
  }

  Future<void> addAdminRights(String userId) async {
    await client.post(endpoint: '/users/give-admin-rights?userId=$userId');
  }

  Future<void> removeAdminRights(String userId) async {
    await client.post(endpoint: '/users/remove-admin-rights?userId=$userId');
  }
}
