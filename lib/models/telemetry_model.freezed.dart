// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'telemetry_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TelemetryModel _$TelemetryModelFromJson(Map<String, dynamic> json) {
  return _TelemetryModel.fromJson(json);
}

/// @nodoc
mixin _$TelemetryModel {
  @JsonKey(name: 'telemetryId')
  int get id => throw _privateConstructorUsedError;
  int get altitude => throw _privateConstructorUsedError;
  int get timestamp => throw _privateConstructorUsedError;
  int get temperature => throw _privateConstructorUsedError;
  int get velocity => throw _privateConstructorUsedError;
  int get radiation => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TelemetryModelCopyWith<TelemetryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TelemetryModelCopyWith<$Res> {
  factory $TelemetryModelCopyWith(
          TelemetryModel value, $Res Function(TelemetryModel) then) =
      _$TelemetryModelCopyWithImpl<$Res, TelemetryModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'telemetryId') int id,
      int altitude,
      int timestamp,
      int temperature,
      int velocity,
      int radiation});
}

/// @nodoc
class _$TelemetryModelCopyWithImpl<$Res, $Val extends TelemetryModel>
    implements $TelemetryModelCopyWith<$Res> {
  _$TelemetryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? altitude = null,
    Object? timestamp = null,
    Object? temperature = null,
    Object? velocity = null,
    Object? radiation = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      altitude: null == altitude
          ? _value.altitude
          : altitude // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      temperature: null == temperature
          ? _value.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as int,
      velocity: null == velocity
          ? _value.velocity
          : velocity // ignore: cast_nullable_to_non_nullable
              as int,
      radiation: null == radiation
          ? _value.radiation
          : radiation // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TelemetryModelImplCopyWith<$Res>
    implements $TelemetryModelCopyWith<$Res> {
  factory _$$TelemetryModelImplCopyWith(_$TelemetryModelImpl value,
          $Res Function(_$TelemetryModelImpl) then) =
      __$$TelemetryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'telemetryId') int id,
      int altitude,
      int timestamp,
      int temperature,
      int velocity,
      int radiation});
}

/// @nodoc
class __$$TelemetryModelImplCopyWithImpl<$Res>
    extends _$TelemetryModelCopyWithImpl<$Res, _$TelemetryModelImpl>
    implements _$$TelemetryModelImplCopyWith<$Res> {
  __$$TelemetryModelImplCopyWithImpl(
      _$TelemetryModelImpl _value, $Res Function(_$TelemetryModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? altitude = null,
    Object? timestamp = null,
    Object? temperature = null,
    Object? velocity = null,
    Object? radiation = null,
  }) {
    return _then(_$TelemetryModelImpl(
      null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      null == altitude
          ? _value.altitude
          : altitude // ignore: cast_nullable_to_non_nullable
              as int,
      null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      null == temperature
          ? _value.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as int,
      null == velocity
          ? _value.velocity
          : velocity // ignore: cast_nullable_to_non_nullable
              as int,
      null == radiation
          ? _value.radiation
          : radiation // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TelemetryModelImpl implements _TelemetryModel {
  const _$TelemetryModelImpl(
      @JsonKey(name: 'telemetryId') this.id,
      this.altitude,
      this.timestamp,
      this.temperature,
      this.velocity,
      this.radiation);

  factory _$TelemetryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TelemetryModelImplFromJson(json);

  @override
  @JsonKey(name: 'telemetryId')
  final int id;
  @override
  final int altitude;
  @override
  final int timestamp;
  @override
  final int temperature;
  @override
  final int velocity;
  @override
  final int radiation;

  @override
  String toString() {
    return 'TelemetryModel(id: $id, altitude: $altitude, timestamp: $timestamp, temperature: $temperature, velocity: $velocity, radiation: $radiation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TelemetryModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.altitude, altitude) ||
                other.altitude == altitude) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.temperature, temperature) ||
                other.temperature == temperature) &&
            (identical(other.velocity, velocity) ||
                other.velocity == velocity) &&
            (identical(other.radiation, radiation) ||
                other.radiation == radiation));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, altitude, timestamp, temperature, velocity, radiation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TelemetryModelImplCopyWith<_$TelemetryModelImpl> get copyWith =>
      __$$TelemetryModelImplCopyWithImpl<_$TelemetryModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TelemetryModelImplToJson(
      this,
    );
  }
}

abstract class _TelemetryModel implements TelemetryModel {
  const factory _TelemetryModel(
      @JsonKey(name: 'telemetryId') final int id,
      final int altitude,
      final int timestamp,
      final int temperature,
      final int velocity,
      final int radiation) = _$TelemetryModelImpl;

  factory _TelemetryModel.fromJson(Map<String, dynamic> json) =
      _$TelemetryModelImpl.fromJson;

  @override
  @JsonKey(name: 'telemetryId')
  int get id;
  @override
  int get altitude;
  @override
  int get timestamp;
  @override
  int get temperature;
  @override
  int get velocity;
  @override
  int get radiation;
  @override
  @JsonKey(ignore: true)
  _$$TelemetryModelImplCopyWith<_$TelemetryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
