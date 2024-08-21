import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:onboarding/models/user_jwt_model.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel(
    String? id,
    bool isDeleted,
    String? name,
    List<String?> userRoles,
  ) = _UserModel;

  const UserModel._();

  bool get isAdmin => userRoles.contains('Administrator');

  factory UserModel.empty() => const UserModel(null, false, null, []);

  factory UserModel.fromJWT(Map<String, dynamic> json) => UserJWTModel.fromJson(json).userResponse;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}
