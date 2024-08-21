// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:onboarding/models/user_model.dart';

part 'user_jwt_model.freezed.dart';
part 'user_jwt_model.g.dart';

@freezed
class UserJWTModel with _$UserJWTModel {
  const factory UserJWTModel(
    @JsonKey(name: 'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name') String? name,
    @JsonKey(name: 'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress')
    String email,
    @JsonKey(name: 'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier')
    String? id,
    @JsonKey(name: 'http://schemas.microsoft.com/ws/2008/06/identity/claims/role')
    List<String?> roles,
  ) = _UserJWTModel;

  const UserJWTModel._();

  get userResponse => UserModel(id, false, name, roles);

  factory UserJWTModel.fromJson(Map<String, dynamic> json) => _$UserJWTModelFromJson(json);
}
