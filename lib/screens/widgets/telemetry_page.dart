import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding/bloc/telemetry/telemetry_bloc.dart';
import 'package:onboarding/bloc/telemetry/telemetry_event.dart';
import 'package:onboarding/bloc/telemetry/telemetry_state.dart';
import 'package:onboarding/enums/telemetry_column.dart';
import 'package:onboarding/models/telemetry_model.dart';

// ignore: must_be_immutable
class TelemetryPage extends StatelessWidget {
  TelemetryPage({super.key});

  DateTime? _selectedDate;
  final TextEditingController _minAltitudeController = TextEditingController();
  final TextEditingController _maxAltitudeController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<TelemetryColumn> columnNames = [
    TelemetryColumn.id,
    TelemetryColumn.altitude,
    TelemetryColumn.timestamp,
    TelemetryColumn.temperature,
    TelemetryColumn.velocity,
    TelemetryColumn.radiation,
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

  void onSort(TelemetryState state, BuildContext context, TelemetryColumn column, bool ascending) {
    context.read<TelemetryBloc>().add(
        SortTelemetry(telemetries: state.telemetries, sortColumn: column, isAscending: ascending));
  }

  void onScroll(TelemetryState state, BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        context.read<TelemetryBloc>().add(FetchTelemetry(
              sortColumn: state.sortColumn,
              isAscending: state.isAscending,
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
      create: (context) => TelemetryBloc()
        ..add(FetchTelemetry(
          sortColumn: TelemetryColumn.id,
          isAscending: false,
        )),
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
            child: BlocListener<TelemetryBloc, TelemetryState>(
              listener: (context, state) {
                onScroll(state, context);
              },
              child: BlocBuilder<TelemetryBloc, TelemetryState>(
                builder: (context, state) {
                  if (state.errorMessage.isNotEmpty) {
                    return Center(child: Text(state.errorMessage));
                  }

                  return NotificationListener(
                    onNotification: (notification) {
                      if (notification is ScrollEndNotification) {
                        onScroll(state, context);
                      }
                      return true;
                    },
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              sortColumnIndex: state.sortColumn.index,
                              sortAscending: state.isAscending,
                              columns: columnNames
                                  .map((column) => DataColumn(
                                      label: Text(column.label),
                                      onSort: (i, asc) => onSort(state, context, column, asc)))
                                  .toList(),
                              rows: buildDataRows(state.telemetries),
                            ),
                          ),
                          if (state.isLoading) const Center(child: LinearProgressIndicator()),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
