// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding/bloc/telemetry/telemetry_bloc.dart';
import 'package:onboarding/bloc/telemetry/telemetry_event.dart';
import 'package:onboarding/bloc/telemetry/telemetry_state.dart';
import 'package:onboarding/models/telemetry_model.dart';

// ignore: must_be_immutable
class TelemetryPage extends StatelessWidget {
  TelemetryPage({super.key});

  DateTime? _selectedDate;
  final TextEditingController _minAltitudeController = TextEditingController();
  final TextEditingController _maxAltitudeController = TextEditingController();

  final List<String> columnNames = [
    'ID',
    'Altitude',
    'Timestamp',
    'Temperature',
    'Velocity',
    'Radiation',
  ];

  void _onFilter() {
    /*
      final minAltitude = int.tryParse(_minAltitudeController.text);
      final maxAltitude = int.tryParse(_maxAltitudeController.text);

      context.read<TelemetryBloc>().add(FilterTelemetry(
            date: _selectedDate,
            minAltitude: minAltitude,
            maxAltitude: maxAltitude,
          ));*/
  }

  Future<void> _selectDate(BuildContext context) async {
    /*
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );
      if (picked != null && picked != _selectedDate) {
        _selectedDate = picked;
      }*/
  }

  @override
  Widget build(BuildContext context) {
    String? getColumnName(int index) {
      switch (index) {
        case 0:
          return 'telemetryId';
        case 1:
          return 'altitude';
        case 2:
          return 'timestamp';
        case 3:
          return 'temperature';
        case 4:
          return 'velocity';
        case 5:
          return 'radiation';
        default:
          return null;
      }
    }

    int? getColumnIndex(String columnName) {
      switch (columnName) {
        case 'telemetryId':
          return 0;
        case 'altitude':
          return 1;
        case 'timestamp':
          return 2;
        case 'temperature':
          return 3;
        case 'velocity':
          return 4;
        case 'radiation':
          return 5;
        default:
          return null;
      }
    }

    void onSort(TelemetryState state, BuildContext context, int columnIndex, bool ascending) {
      final column = getColumnName(columnIndex)!;

      context.read<TelemetryBloc>().add(SortTelemetry(sortProp: column, isAscending: ascending));
    }

    List<DataRow> buildDataRows(List<TelemetryModel> telemetryList) {
      return telemetryList
          .map(
            (telemetry) => DataRow(cells: [
              DataCell(Text(telemetry.id.toString())),
              DataCell(Text(telemetry.altitude.toString())),
              DataCell(Text(DateTime.fromMillisecondsSinceEpoch(telemetry.timestamp * 1000)
                  .toLocal()
                  .toString())),
              DataCell(Text(telemetry.temperature.toString())),
              DataCell(Text(telemetry.velocity.toString())),
              DataCell(Text(telemetry.radiation.toString())),
            ]),
          )
          .toList();
    }

    return BlocProvider<TelemetryBloc>(
      create: (context) => TelemetryBloc(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _minAltitudeController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Min Altitude',
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _maxAltitudeController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Max Altitude',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Text(_selectedDate == null
                      ? 'Choose Date'
                      : "${_selectedDate!.toLocal()}".split(' ')[0]),
                ),
                ElevatedButton(
                  onPressed: _onFilter,
                  child: const Text('Apply Filters'),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<TelemetryBloc, TelemetryState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.errorMessage.isNotEmpty) {
                  return Center(child: Text(state.errorMessage));
                }

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    sortColumnIndex: getColumnIndex(state.sortProp),
                    sortAscending: state.isAscending,
                    columns: columnNames
                        .map((column) => DataColumn(
                            label: Text(column),
                            onSort: (i, asc) => onSort(state, context, i, asc)))
                        .toList(),
                    rows: buildDataRows(state.telemetries),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
