import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:onboarding/models/login_model.dart';
import 'package:onboarding/repositories/storage_repository.dart';

class HttpClient {
  final String baseUrl;
  final StorageRepository storageRepository;
  void Function() onUnauthorized;

  HttpClient._(
      {required this.baseUrl, required this.storageRepository, required this.onUnauthorized});

  static final HttpClient i = HttpClient._(
    // TODO: Update the base URL according to the API server
    baseUrl: "http://127.0.0.1:5104",
    storageRepository: StorageRepository.i,
    onUnauthorized: () => {},
  );

  Future<String> get token =>
      storageRepository.readTokenData().then((value) => value[0] ?? '').catchError((e) => '');

  Future<DateTime> get tokenExpiration => storageRepository
      .readTokenData()
      .then((value) => value[1] != null ? DateTime.parse(value[1]!) : DateTime(0));

  Future<http.Response> get({required String endpoint, void Function()? unauthorizedHandle}) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final http.Response response;
    try {
      response = await http.get(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Accept": "*/*",
          "Authorization": "Bearer ${await token}",
        },
      );
    } catch (e) {
      throw Exception('Failed to send request');
    }

    if (response.statusCode == 401) {
      if (unauthorizedHandle != null) {
        unauthorizedHandle();
      } else {
        onUnauthorized();
      }
      throw Exception(response.body);
    }

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    return response;
  }

  Future<http.Response> delete(
      {required String endpoint,
      Map<String, dynamic>? data,
      void Function()? unauthorizedHandle}) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final http.Response response;

    try {
      response = await http.delete(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Accept": "*/*",
          "Authorization": "Bearer ${await token}",
        },
        body: jsonEncode(data),
      );
    } catch (e) {
      throw Exception('Failed to send request');
    }

    if (response.statusCode == 401) {
      if (unauthorizedHandle != null) {
        unauthorizedHandle();
      } else {
        onUnauthorized();
      }
      throw Exception(response.body);
    }

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    return response;
  }

  Future<http.Response> post(
      {required String endpoint,
      Map<String, dynamic>? data,
      void Function()? unauthorizedHandle}) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final http.Response response;
    try {
      response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Accept": "*/*",
          "Authorization": "Bearer ${await token}",
        },
        body: jsonEncode(data),
      );
    } catch (e) {
      throw Exception('Failed to send request');
    }

    if (response.statusCode == 401) {
      if (unauthorizedHandle != null) {
        unauthorizedHandle();
      } else {
        onUnauthorized();
      }
      throw Exception(response.body);
    }

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    return response;
  }

  Future<void> deleteToken() async {
    await storageRepository.deleteTokenData();
  }

  Future<void> updateToken(LoginModel login) async {
    await storageRepository.writeTokenData(login);
  }
}
