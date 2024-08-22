import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding/bloc/telemetry/telemetry_bloc.dart';
import 'package:onboarding/bloc/telemetry/telemetry_event.dart';
import 'package:onboarding/bloc/telemetry/telemetry_state.dart';
import 'package:onboarding/enums/telemetry_column.dart';
import 'package:onboarding/helpers/helper.dart';
import 'package:onboarding/repositories/auth_repository.dart';

class TelemetryPage extends StatelessWidget {
  TelemetryPage({super.key});

  final TextEditingController _minAltitudeController = TextEditingController();
  final TextEditingController _maxAltitudeController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final _isAdmin = AuthRepository.i.user.isAdmin;

  final List<TelemetryColumn> columnNames = [
    TelemetryColumn.id,
    TelemetryColumn.altitude,
    TelemetryColumn.timestamp,
    TelemetryColumn.temperature,
    TelemetryColumn.velocity,
    TelemetryColumn.radiation,
  ];

  void onFilter(BuildContext context, TelemetryColumn sortColumn) {
    final minAltitude = int.tryParse(_minAltitudeController.text);
    final maxAltitude = int.tryParse(_maxAltitudeController.text);

    context
        .read<TelemetryBloc>()
        .add(FilterTelemetry(minAltitude: minAltitude, maxAltitude: maxAltitude));
  }

  void onSort(BuildContext context, TelemetryState state, TelemetryColumn column, bool ascending) {
    context.read<TelemetryBloc>().add(
        SortTelemetry(telemetries: state.telemetries, sortColumn: column, isAscending: ascending));
  }

  void onScroll(BuildContext context, TelemetryState state) {
    if (state.hasReachedMax) {
      return;
    }

    if (context.mounted &&
        _scrollController.positions.isNotEmpty &&
        _scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      context.read<TelemetryBloc>().add(FetchTelemetry(
            sortColumn: state.sortColumn,
            isAscending: state.isAscending,
            startDate: state.startDate,
            endDate: state.endDate,
          ));
    }
  }

  List<DataRow> buildDataRows(BuildContext context, TelemetryState state) {
    return state.telemetries
        .map(
          (telemetry) => DataRow(
              selected: telemetry.id == state.selectedTelemetryId,
              onSelectChanged: (selected) {
                context.read<TelemetryBloc>().add(SelectTelemetry(telemetryId: telemetry.id));
              },
              cells: [
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TelemetryBloc>(
      create: (context) {
        return TelemetryBloc()
          ..add(FetchTelemetry(
              sortColumn: TelemetryColumn.id,
              isAscending: false,
              startDate: DateTime.now(),
              endDate: DateTime.now()));
      },
      child: BlocListener<TelemetryBloc, TelemetryState>(
        listener: (context, state) {
          onScroll(context, state);
          if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<TelemetryBloc, TelemetryState>(builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
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
                        const SizedBox(
                          width: 8,
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
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () => Helper.selectDate(
                              context: context,
                              onDateRangeSelected: (startDate, endDate) => {
                                    context
                                        .read<TelemetryBloc>()
                                        .add(SetDateRange(startDate: startDate, endDate: endDate)),
                                  }),
                          child: Text(
                              "${state.startDate.toLocal().toString().split(' ')[0]} - ${state.endDate.toLocal().toString().split(' ')[0]}"),
                        ),
                        ElevatedButton(
                          onPressed: () => onFilter(context, state.sortColumn),
                          child: const Text('Apply Filters'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              state.selectedTelemetryId != -1
                  ? Column(
                      children: [
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Text('Selected: ${state.selectedTelemetryId}'),
                              const Expanded(
                                child: SizedBox.shrink(),
                              ),
                              _isAdmin
                                  ? ElevatedButton(
                                      onPressed: () {
                                        context.read<TelemetryBloc>().add(DeleteTelemetry(
                                            telemetryId: state.selectedTelemetryId));
                                      },
                                      child: const Icon(Icons.delete_outline),
                                    )
                                  : const SizedBox.shrink(),
                              const SizedBox(
                                width: 8,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  context
                                      .read<TelemetryBloc>()
                                      .add(LikeTelemetry(telemetryId: state.selectedTelemetryId));
                                },
                                child: const Icon(Icons.favorite_outline),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  context
                                      .read<TelemetryBloc>()
                                      .add(SelectTelemetry(telemetryId: -1));
                                },
                                child: const Icon(Icons.close),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  : const SizedBox.shrink(),
              Expanded(
                child: NotificationListener(
                  onNotification: (notification) {
                    if (notification is ScrollEndNotification) {
                      onScroll(context, state);
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
                                    onSort: (i, asc) => onSort(context, state, column, asc)))
                                .toList(),
                            rows: buildDataRows(context, state),
                          ),
                        ),
                        Center(
                          child: state.isLoading
                              ? const LinearProgressIndicator()
                              : const SizedBox(
                                  height: 8,
                                ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
