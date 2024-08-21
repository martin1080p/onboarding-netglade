// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      json['id'] as String?,
      json['isDeleted'] as bool,
      json['name'] as String?,
      (json['userRoles'] as List<dynamic>).map((e) => e as String?).toList(),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isDeleted': instance.isDeleted,
      'name': instance.name,
      'userRoles': instance.userRoles,
    };
