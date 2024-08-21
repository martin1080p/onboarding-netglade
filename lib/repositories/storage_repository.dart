import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageRepository {
  final FlutterSecureStorage storage;

  StorageRepository._() : storage = const FlutterSecureStorage();

  static final StorageRepository i = StorageRepository._();

  final String tokenKey = 'token';

  Future<void> writeToken(String value) async {
    await storage.write(key: tokenKey, value: value);
  }

  Future<String?> readToken() async {
    return await storage.read(key: tokenKey);
  }

  Future<void> deleteToken() async {
    await storage.delete(key: tokenKey);
  }
}
