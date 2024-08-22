import 'dart:convert';

import 'package:onboarding/api/client.dart';
import 'package:onboarding/bloc/favorite/favorite_state.dart';
import 'package:onboarding/bloc/telemetry/telemetry_state.dart';
import 'package:onboarding/helpers/helper.dart';
import 'package:onboarding/models/telemetry_model.dart';
import 'package:onboarding/repositories/auth_repository.dart';

class TelemetryRepository {
  final HttpClient client;
  final AuthRepository authRepository;

  TelemetryRepository._({required this.client, required this.authRepository});

  static final TelemetryRepository i =
      TelemetryRepository._(client: HttpClient.i, authRepository: AuthRepository.i);

  Future<List<TelemetryModel>> getFavouriteTelemetries(FavoriteState state) async {
    final int startTimestamp = Helper.timestampFromDate(state.startDate);
    final int endTimestamp = Helper.timestampFromDate(state.endDate, isEndOfDay: true);
    final response = await client.get(
        endpoint:
            '/favourite-telemetry?userId=${authRepository.user.id}&startingTimeStamp=$startTimestamp&endingTimeStamp=$endTimestamp');

    List<TelemetryModel> telemetries =
        (jsonDecode(response.body) as List).map((e) => TelemetryModel.fromJson(e)).toList();

    return telemetries;
  }

  Future<void> likeTelemetry(int telemetryId) async {
    await client.post(
        endpoint: '/favourite-telemetry?userId=${authRepository.user.id}&telemetryId=$telemetryId');
  }

  Future<void> unlikeTelemetry(int telemetryId) async {
    await client.delete(
        endpoint: '/favourite-telemetry?userId=${authRepository.user.id}&telemetryId=$telemetryId');
  }

  Future<void> deleteTelemetry(int telemetryId) async {
    await client.delete(endpoint: '/telemetry?telemetryId=$telemetryId');
  }

  Future<List<TelemetryModel>> getTelemetries(TelemetryState state) async {
    final int startTimestamp = Helper.timestampFromDate(state.startDate);
    final int endTimestamp = Helper.timestampFromDate(state.endDate, isEndOfDay: true);
    final response = await client.get(
        endpoint:
            '/telemetry?startingTimeStamp=$startTimestamp&endingTimeStamp=$endTimestamp&lowestAltitude=${state.minAltitudeFilter}&highestAltitude=${state.maxAltitudeFilter}&page=${state.page}&pageSize=${state.pageSize}');

    List<TelemetryModel> telemetries =
        (jsonDecode(response.body) as List).map((e) => TelemetryModel.fromJson(e)).toList();

    return telemetries;
  }
}
