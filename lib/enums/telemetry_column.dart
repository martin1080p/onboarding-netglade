import 'package:onboarding/models/telemetry_model.dart';

enum TelemetryColumn {
  id(position: 0, name: 'telemetryId', label: 'ID'),
  altitude(position: 1, name: 'altitude', label: 'Altitude'),
  timestamp(position: 2, name: 'timestamp', label: 'Timestamp'),
  temperature(position: 3, name: 'temperature', label: 'Temperature'),
  velocity(position: 4, name: 'velocity', label: 'Velocity'),
  radiation(position: 5, name: 'radiation', label: 'Radiation');

  const TelemetryColumn({
    required this.position,
    required this.name,
    required this.label,
  });

  final int position;
  final String name;
  final String label;

  Comparable<dynamic> getValue(TelemetryModel telemetry) {
    Map<TelemetryColumn, dynamic> map = {
      TelemetryColumn.id: telemetry.id,
      TelemetryColumn.altitude: telemetry.altitude,
      TelemetryColumn.timestamp: telemetry.timestamp,
      TelemetryColumn.temperature: telemetry.temperature,
      TelemetryColumn.velocity: telemetry.velocity,
      TelemetryColumn.radiation: telemetry.radiation,
    };
    return map[this];
  }
}
