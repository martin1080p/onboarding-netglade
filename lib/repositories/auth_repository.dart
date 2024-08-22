import 'dart:convert';

import 'package:onboarding/api/client.dart';
import 'package:onboarding/helpers/jwt_decoder.dart';
import 'package:onboarding/models/login_model.dart';
import 'package:onboarding/models/register_model.dart';
import 'package:onboarding/models/user_model.dart';

class AuthRepository {
  final HttpClient client;
  UserModel user = UserModel.empty();

  AuthRepository._({required this.client});

  static final AuthRepository i = AuthRepository._(client: HttpClient.i);

  Future<LoginModel> login(String username, String password) async {
    final response = await client.post(
      endpoint: '/login',
      data: {
        'username': username,
        'password': password,
      },
    );

    LoginModel loginModel = LoginModel.fromJson(jsonDecode(response.body));
    client.updateToken(loginModel.token);
    user = JwtDecoder.decodeUser(loginModel.token);

    return loginModel;
  }

  Future<LoginModel> register(String username, String email, String password) async {
    final response = await client.post(
      endpoint: '/register',
      data: {
        'username': username,
        'email': email,
        'password': password,
      },
    );

    RegisterModel registerModel = RegisterModel.fromJson(jsonDecode(response.body));

    if (registerModel.succeeded) {
      return await login(username, password);
    } else {
      throw Exception(registerModel.error);
    }
  }

  Future<LoginModel> registerAdmin(String username, String email, String password) async {
    final response = await client.post(
      endpoint: '/register-admin',
      data: {
        'username': username,
        'email': email,
        'password': password,
      },
    );

    RegisterModel registerModel = RegisterModel.fromJson(jsonDecode(response.body));

    if (registerModel.succeeded) {
      return await login(username, password);
    } else {
      throw Exception(registerModel.error);
    }
  }
}
