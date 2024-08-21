import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:onboarding/models/user_model.dart';

class JwtDecoder {
  static UserModel decodeUser(String token) {
    final decodedToken = JWT.decode(token);
    return UserModel.fromJWT(decodedToken.payload);
  }
}
