import 'dart:convert';

import 'package:onboarding/api/client.dart';
import 'package:onboarding/bloc/app/app_bloc.dart';
import 'package:onboarding/bloc/app/app_event.dart';
import 'package:onboarding/helpers/jwt_decoder.dart';
import 'package:onboarding/models/login_model.dart';
import 'package:onboarding/models/register_model.dart';
import 'package:onboarding/models/user_model.dart';

class AuthRepository {
  final HttpClient client;
  UserModel user = UserModel.empty();

  AuthRepository._({required this.client}) {
    client.onUnauthorized = () {
      logout(hasSessionExpired: true);
    };
  }

  static final AuthRepository i = AuthRepository._(client: HttpClient.i);

  Future<LoginModel> login(String username, String password) async {
    final response = await client.post(
      endpoint: '/login',
      data: {
        'username': username,
        'password': password,
      },
      unauthorizedHandle: () {
        throw 'Wrong username or password';
      },
    );

    LoginModel loginModel = LoginModel.fromJson(jsonDecode(response.body));

    client.updateToken(loginModel);

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

  Future<void> logout({bool hasSessionExpired = false}) async {
    user = UserModel.empty();
    await client.deleteToken();
    AppBloc.i.add(Logout(hasSessionExpired: hasSessionExpired));
  }

  Future<bool> isUserLoggedIn() async {
    if (DateTime.now().isBefore(await client.tokenExpiration)) {
      user = JwtDecoder.decodeUser(await client.token);
      return true;
    } else {
      return false;
    }
  }
}
