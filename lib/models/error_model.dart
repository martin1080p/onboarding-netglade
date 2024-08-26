// ignore_for_file: invalid_annotation_target

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_model.freezed.dart';
part 'error_model.g.dart';

@freezed
class ErrorModel with _$ErrorModel {
  factory ErrorModel(
    int id,
    @JsonKey(name: 'errorData') String data,
    int timestamp,
  ) = _ErrorModel;

  ErrorModel._();

  List<int> get dataBytes => base64Decode(data);
  String get originalString => utf8.decode(dataBytes);

  factory ErrorModel.fromJson(Map<String, dynamic> json) => _$ErrorModelFromJson(json);
}
