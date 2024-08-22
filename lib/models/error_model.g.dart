// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ErrorModelImpl _$$ErrorModelImplFromJson(Map<String, dynamic> json) =>
    _$ErrorModelImpl(
      (json['id'] as num).toInt(),
      json['errorData'] as String,
      (json['timestamp'] as num).toInt(),
    );

Map<String, dynamic> _$$ErrorModelImplToJson(_$ErrorModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'errorData': instance.data,
      'timestamp': instance.timestamp,
    };
