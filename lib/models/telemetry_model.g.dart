// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'telemetry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TelemetryModelImpl _$$TelemetryModelImplFromJson(Map<String, dynamic> json) =>
    _$TelemetryModelImpl(
      (json['telemetryId'] as num).toInt(),
      (json['altitude'] as num).toInt(),
      (json['timestamp'] as num).toInt(),
      (json['temperature'] as num).toInt(),
      (json['velocity'] as num).toInt(),
      (json['radiation'] as num).toInt(),
    );

Map<String, dynamic> _$$TelemetryModelImplToJson(
        _$TelemetryModelImpl instance) =>
    <String, dynamic>{
      'telemetryId': instance.id,
      'altitude': instance.altitude,
      'timestamp': instance.timestamp,
      'temperature': instance.temperature,
      'velocity': instance.velocity,
      'radiation': instance.radiation,
    };
