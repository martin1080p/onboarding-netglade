import 'dart:convert';

import 'package:onboarding/api/client.dart';
import 'package:onboarding/bloc/error/error_state.dart';
import 'package:onboarding/models/error_model.dart';

class ErrorRepository {
  final HttpClient client;

  ErrorRepository._({required this.client});

  static final ErrorRepository i = ErrorRepository._(client: HttpClient.i);

  Future<List<ErrorModel>> getNewErrors(ErrorState state) async {
    final response =
        await client.get(endpoint: '/telemetry/errors?page=1&pageSize=${state.pageSize}');
    List<ErrorModel> errors =
        (jsonDecode(response.body) as List).map((e) => ErrorModel.fromJson(e)).toList();
    return errors;
  }

  Future<List<ErrorModel>> getErrors(ErrorState state) async {
    final response = await client.get(
        endpoint: '/telemetry/errors?page=${state.page}&pageSize=${state.pageSize}');
    List<ErrorModel> errors =
        (jsonDecode(response.body) as List).map((e) => ErrorModel.fromJson(e)).toList();
    return errors;
  }

  Future<void> deleteError(int errorId) async {
    await client.delete(endpoint: '/telemetry/errors?errorId=$errorId');
  }
}
