import 'package:onboarding/api/client.dart';
import 'package:onboarding/models/telemetry_model.dart';

class TelemetryRepository {
  final HttpClient client;
  final int pageSize = 10;

  TelemetryRepository._({required this.client});

  static final TelemetryRepository i = TelemetryRepository._(client: HttpClient.i);

  Future<List<TelemetryModel>> getTelemetries(int page) async {
    final response = await client.get('/telemetries?page=$page&pageSize=$pageSize');
    return (response.body as List).map((e) => TelemetryModel.fromJson(e)).toList();
  }
}
