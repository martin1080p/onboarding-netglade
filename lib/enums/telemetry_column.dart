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

  dynamic getValue(TelemetryModel telemetry) {
    switch (this) {
      case TelemetryColumn.id:
        return telemetry.id;
      case TelemetryColumn.altitude:
        return telemetry.altitude;
      case TelemetryColumn.timestamp:
        return telemetry.timestamp;
      case TelemetryColumn.temperature:
        return telemetry.temperature;
      case TelemetryColumn.velocity:
        return telemetry.velocity;
      case TelemetryColumn.radiation:
        return telemetry.radiation;
    }
  }
}
