import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:onboarding/models/login_model.dart';

class StorageRepository {
  final FlutterSecureStorage storage;

  StorageRepository._() : storage = const FlutterSecureStorage();

  static final StorageRepository i = StorageRepository._();

  final String tokenKey = 'token';
  final String tokenExpirationKey = 'token-expiration';

  Future<void> writeTokenData(LoginModel login) async {
    await storage.write(key: tokenKey, value: login.token);
    await storage.write(key: tokenExpirationKey, value: login.expiresAt);
  }

  Future<List<String?>> readTokenData() async {
    return [await storage.read(key: tokenKey), await storage.read(key: tokenExpirationKey)];
  }

  Future<void> deleteTokenData() async {
    await storage.delete(key: tokenKey);
    await storage.delete(key: tokenExpirationKey);
  }
}
