import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:onboarding/repositories/storage_repository.dart';

class HttpClient {
  final String baseUrl;
  final StorageRepository storageRepository;
  String token = '';

  HttpClient._({required this.baseUrl, required this.storageRepository});

  static final HttpClient i = HttpClient._(
    baseUrl: "http://192.168.1.16:5104",
    storageRepository: StorageRepository.i,
  );

  Future<http.Response> get({required String endpoint}) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final http.Response response;
    try {
      response = await http.get(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Accept": "*/*",
          "Authorization": "Bearer $token",
        },
      );
    } catch (e) {
      throw Exception('Failed to send request');
    }

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    return response;
  }

  Future<http.Response> delete({required String endpoint, Map<String, dynamic>? data}) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final http.Response response;

    try {
      response = await http.delete(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Accept": "*/*",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(data),
      );
    } catch (e) {
      throw Exception('Failed to send request');
    }

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    return response;
  }

  Future<http.Response> post({required String endpoint, Map<String, dynamic>? data}) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final http.Response response;
    try {
      response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Accept": "*/*",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(data),
      );
    } catch (e) {
      throw Exception('Failed to send request');
    }

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    return response;
  }

  Future<void> updateToken(String token) async {
    this.token = token;
    await storageRepository.writeToken(token);
  }
}
