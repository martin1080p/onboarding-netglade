import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding/bloc/chart/chart_bloc.dart';
import 'package:onboarding/bloc/chart/chart_event.dart';
import 'package:onboarding/bloc/chart/chart_state.dart';

class ChartPage extends StatelessWidget {
  const ChartPage({super.key});

  final pointsPerChart = 20;

  Widget buildTemperatureChart(ChartState state) {
    final telemetries = state.telemetries.sublist(0, pointsPerChart);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Temperature Chart',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              height: 300,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: true),
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 30,
                        reservedSize: 28,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            DateTime.fromMillisecondsSinceEpoch(value.toInt() * 1000)
                                .toString()
                                .substring(11, 19),
                            style: const TextStyle(fontSize: 10),
                          );
                        },
                      ),
                    ),
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: true, reservedSize: 35),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: const Color(0xff37434d), width: 1),
                  ),
                  minX: telemetries.map((e) => e.timestamp).reduce(min).toDouble(),
                  maxX: telemetries.map((e) => e.timestamp).reduce(max).toDouble(),
                  minY: telemetries.map((e) => e.temperature).reduce(min).toDouble() - 10,
                  maxY: telemetries.map((e) => e.temperature).reduce(max).toDouble() + 10,
                  lineBarsData: [
                    LineChartBarData(
                      spots: telemetries
                          .map((e) => FlSpot(e.timestamp.toDouble(), e.temperature.toDouble()))
                          .toList(),
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 3,
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.blue.withOpacity(0.3),
                      ),
                      dotData: const FlDotData(show: true),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRadiationChart(ChartState state) {
    final telemetries = state.telemetries.sublist(0, pointsPerChart);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Radiation Chart',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              height: 300,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: true),
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 30,
                        reservedSize: 28,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            DateTime.fromMillisecondsSinceEpoch(value.toInt() * 1000)
                                .toString()
                                .substring(11, 19),
                            style: const TextStyle(fontSize: 10),
                          );
                        },
                      ),
                    ),
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: true, reservedSize: 50),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: const Color(0xff37434d), width: 1),
                  ),
                  minX: telemetries.map((e) => e.timestamp).reduce(min).toDouble(),
                  maxX: telemetries.map((e) => e.timestamp).reduce(max).toDouble(),
                  minY: max(telemetries.map((e) => e.radiation).reduce(min).toDouble() - 200, 0),
                  maxY: telemetries.map((e) => e.radiation).reduce(max).toDouble() + 200,
                  lineBarsData: [
                    LineChartBarData(
                      spots: telemetries
                          .map((e) => FlSpot(e.timestamp.toDouble(), e.radiation.toDouble()))
                          .toList(),
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 3,
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.blue.withOpacity(0.3),
                      ),
                      dotData: const FlDotData(show: true),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAltitudeChart(ChartState state) {
    final telemetries = state.telemetries.sublist(0, pointsPerChart);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Altitude Chart',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              height: 300,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: true),
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 30,
                        reservedSize: 28,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            DateTime.fromMillisecondsSinceEpoch(value.toInt() * 1000)
                                .toString()
                                .substring(11, 19),
                            style: const TextStyle(fontSize: 10),
                          );
                        },
                      ),
                    ),
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: true, reservedSize: 50),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: const Color(0xff37434d), width: 1),
                  ),
                  minX: telemetries.map((e) => e.timestamp).reduce(min).toDouble(),
                  maxX: telemetries.map((e) => e.timestamp).reduce(max).toDouble(),
                  minY: telemetries.map((e) => e.altitude).reduce(min).toDouble() - 20e7,
                  maxY: telemetries.map((e) => e.altitude).reduce(max).toDouble() + 20e7,
                  lineBarsData: [
                    LineChartBarData(
                      spots: telemetries
                          .map((e) => FlSpot(e.timestamp.toDouble(), e.altitude.toDouble()))
                          .toList(),
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 3,
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.blue.withOpacity(0.3),
                      ),
                      dotData: const FlDotData(show: true),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildVelocityChart(ChartState state) {
    final telemetries = state.telemetries.sublist(0, pointsPerChart);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Velocity Chart',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              height: 300,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: true),
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 30,
                        reservedSize: 28,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            DateTime.fromMillisecondsSinceEpoch(value.toInt() * 1000)
                                .toString()
                                .substring(11, 19),
                            style: const TextStyle(fontSize: 10),
                          );
                        },
                      ),
                    ),
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: true, reservedSize: 50),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: const Color(0xff37434d), width: 1),
                  ),
                  minX: telemetries.map((e) => e.timestamp).reduce(min).toDouble(),
                  maxX: telemetries.map((e) => e.timestamp).reduce(max).toDouble(),
                  minY: max(telemetries.map((e) => e.velocity).reduce(min).toDouble() - 10, 0),
                  maxY: telemetries.map((e) => e.velocity).reduce(max).toDouble() + 10,
                  lineBarsData: [
                    LineChartBarData(
                      spots: telemetries
                          .map((e) => FlSpot(e.timestamp.toDouble(), e.velocity.toDouble()))
                          .toList(),
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 3,
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.blue.withOpacity(0.3),
                      ),
                      dotData: const FlDotData(show: true),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChartBloc>(
      create: (context) {
        return ChartBloc()..add(FetchChart());
      },
      child: BlocListener<ChartBloc, ChartState>(
        listener: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<ChartBloc, ChartState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: (state.isLoading)
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          state.isRefreshing
                              ? const LinearProgressIndicator()
                              : const SizedBox(
                                  height: 4,
                                ),
                          buildTemperatureChart(state),
                          buildRadiationChart(state),
                          buildAltitudeChart(state),
                          buildVelocityChart(state),
                        ],
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}
