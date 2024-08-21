// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_jwt_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserJWTModelImpl _$$UserJWTModelImplFromJson(Map<String, dynamic> json) =>
    _$UserJWTModelImpl(
      json['http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name']
          as String?,
      json['http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress']
          as String,
      json['http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier']
          as String?,
      (json['http://schemas.microsoft.com/ws/2008/06/identity/claims/role']
              as List<dynamic>)
          .map((e) => e as String?)
          .toList(),
    );

Map<String, dynamic> _$$UserJWTModelImplToJson(_$UserJWTModelImpl instance) =>
    <String, dynamic>{
      'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name':
          instance.name,
      'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress':
          instance.email,
      'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier':
          instance.id,
      'http://schemas.microsoft.com/ws/2008/06/identity/claims/role':
          instance.roles,
    };
