// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'telemetry_model.freezed.dart';
part 'telemetry_model.g.dart';

@freezed
class TelemetryModel with _$TelemetryModel {
  const factory TelemetryModel(
    @JsonKey(name: 'telemetryId') int id,
    int altitude,
    int timestamp,
    int temperature,
    int velocity,
    int radiation,
  ) = _TelemetryModel;

  factory TelemetryModel.fromJson(Map<String, dynamic> json) => _$TelemetryModelFromJson(json);
}
