// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_jwt_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserJWTModel _$UserJWTModelFromJson(Map<String, dynamic> json) {
  return _UserJWTModel.fromJson(json);
}

/// @nodoc
mixin _$UserJWTModel {
  @JsonKey(name: 'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(
      name:
          'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress')
  String get email => throw _privateConstructorUsedError;
  @JsonKey(
      name:
          'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(
      name: 'http://schemas.microsoft.com/ws/2008/06/identity/claims/role',
      fromJson: rolesFromJson)
  List<String?> get roles => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserJWTModelCopyWith<UserJWTModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserJWTModelCopyWith<$Res> {
  factory $UserJWTModelCopyWith(
          UserJWTModel value, $Res Function(UserJWTModel) then) =
      _$UserJWTModelCopyWithImpl<$Res, UserJWTModel>;
  @useResult
  $Res call(
      {@JsonKey(
          name: 'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name')
      String name,
      @JsonKey(
          name:
              'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress')
      String email,
      @JsonKey(
          name:
              'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier')
      String id,
      @JsonKey(
          name: 'http://schemas.microsoft.com/ws/2008/06/identity/claims/role',
          fromJson: rolesFromJson)
      List<String?> roles});
}

/// @nodoc
class _$UserJWTModelCopyWithImpl<$Res, $Val extends UserJWTModel>
    implements $UserJWTModelCopyWith<$Res> {
  _$UserJWTModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? id = null,
    Object? roles = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      roles: null == roles
          ? _value.roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<String?>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserJWTModelImplCopyWith<$Res>
    implements $UserJWTModelCopyWith<$Res> {
  factory _$$UserJWTModelImplCopyWith(
          _$UserJWTModelImpl value, $Res Function(_$UserJWTModelImpl) then) =
      __$$UserJWTModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(
          name: 'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name')
      String name,
      @JsonKey(
          name:
              'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress')
      String email,
      @JsonKey(
          name:
              'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier')
      String id,
      @JsonKey(
          name: 'http://schemas.microsoft.com/ws/2008/06/identity/claims/role',
          fromJson: rolesFromJson)
      List<String?> roles});
}

/// @nodoc
class __$$UserJWTModelImplCopyWithImpl<$Res>
    extends _$UserJWTModelCopyWithImpl<$Res, _$UserJWTModelImpl>
    implements _$$UserJWTModelImplCopyWith<$Res> {
  __$$UserJWTModelImplCopyWithImpl(
      _$UserJWTModelImpl _value, $Res Function(_$UserJWTModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? email = null,
    Object? id = null,
    Object? roles = null,
  }) {
    return _then(_$UserJWTModelImpl(
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      null == roles
          ? _value._roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<String?>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserJWTModelImpl extends _UserJWTModel {
  const _$UserJWTModelImpl(
      @JsonKey(
          name: 'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name')
      this.name,
      @JsonKey(
          name:
              'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress')
      this.email,
      @JsonKey(
          name:
              'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier')
      this.id,
      @JsonKey(
          name: 'http://schemas.microsoft.com/ws/2008/06/identity/claims/role',
          fromJson: rolesFromJson)
      final List<String?> roles)
      : _roles = roles,
        super._();

  factory _$UserJWTModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserJWTModelImplFromJson(json);

  @override
  @JsonKey(name: 'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name')
  final String name;
  @override
  @JsonKey(
      name:
          'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress')
  final String email;
  @override
  @JsonKey(
      name:
          'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier')
  final String id;
  final List<String?> _roles;
  @override
  @JsonKey(
      name: 'http://schemas.microsoft.com/ws/2008/06/identity/claims/role',
      fromJson: rolesFromJson)
  List<String?> get roles {
    if (_roles is EqualUnmodifiableListView) return _roles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_roles);
  }

  @override
  String toString() {
    return 'UserJWTModel(name: $name, email: $email, id: $id, roles: $roles)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserJWTModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._roles, _roles));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, email, id,
      const DeepCollectionEquality().hash(_roles));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserJWTModelImplCopyWith<_$UserJWTModelImpl> get copyWith =>
      __$$UserJWTModelImplCopyWithImpl<_$UserJWTModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserJWTModelImplToJson(
      this,
    );
  }
}

abstract class _UserJWTModel extends UserJWTModel {
  const factory _UserJWTModel(
      @JsonKey(
          name: 'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name')
      final String name,
      @JsonKey(
          name:
              'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress')
      final String email,
      @JsonKey(
          name:
              'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier')
      final String id,
      @JsonKey(
          name: 'http://schemas.microsoft.com/ws/2008/06/identity/claims/role',
          fromJson: rolesFromJson)
      final List<String?> roles) = _$UserJWTModelImpl;
  const _UserJWTModel._() : super._();

  factory _UserJWTModel.fromJson(Map<String, dynamic> json) =
      _$UserJWTModelImpl.fromJson;

  @override
  @JsonKey(name: 'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name')
  String get name;
  @override
  @JsonKey(
      name:
          'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress')
  String get email;
  @override
  @JsonKey(
      name:
          'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier')
  String get id;
  @override
  @JsonKey(
      name: 'http://schemas.microsoft.com/ws/2008/06/identity/claims/role',
      fromJson: rolesFromJson)
  List<String?> get roles;
  @override
  @JsonKey(ignore: true)
  _$$UserJWTModelImplCopyWith<_$UserJWTModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
