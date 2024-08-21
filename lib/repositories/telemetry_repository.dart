import 'dart:convert';

import 'package:onboarding/api/client.dart';
import 'package:onboarding/bloc/telemetry/telemetry_state.dart';
import 'package:onboarding/models/telemetry_model.dart';

class TelemetryRepository {
  final HttpClient client;
  final int pageSize = 10;

  TelemetryRepository._({required this.client});

  static final TelemetryRepository i = TelemetryRepository._(client: HttpClient.i);

  Future<List<TelemetryModel>> getTelemetries(TelemetryState state) async {
    final response = await client.get(
        '/telemetry?startingTimeStamp=${state.startTimestamp}&endingTimeStamp=${state.endTimestamp}&lowestAltitude=${state.minAltitudeFilter}&highestAltitude=${state.maxAltitudeFilter}&page=${state.page}&pageSize=$pageSize');

    List<TelemetryModel> telemetries =
        (jsonDecode(response.body) as List).map((e) => TelemetryModel.fromJson(e)).toList();

    return telemetries;
  }
}
