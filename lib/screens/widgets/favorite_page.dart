import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding/bloc/favorite/favorite_bloc.dart';
import 'package:onboarding/bloc/favorite/favorite_event.dart';
import 'package:onboarding/bloc/favorite/favorite_state.dart';
import 'package:onboarding/enums/telemetry_column.dart';
import 'package:onboarding/helpers/helper.dart';

class FavoritePage extends StatelessWidget {
  FavoritePage({super.key});

  final List<TelemetryColumn> columnNames = [
    TelemetryColumn.id,
    TelemetryColumn.altitude,
    TelemetryColumn.timestamp,
    TelemetryColumn.temperature,
    TelemetryColumn.velocity,
    TelemetryColumn.radiation,
  ];

  void onSort(BuildContext context, FavoriteState state, TelemetryColumn column, bool ascending) {
    context.read<FavoriteBloc>().add(
        SortFavorite(telemetries: state.telemetries, sortColumn: column, isAscending: ascending));
  }

  List<DataRow> buildDataRows(BuildContext context, FavoriteState state) {
    return state.telemetries
        .map(
          (telemetry) => DataRow(
              selected: telemetry.id == state.selectedTelemetryId,
              onSelectChanged: (selected) {
                context.read<FavoriteBloc>().add(SelectFavorite(telemetryId: telemetry.id));
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
    return BlocProvider<FavoriteBloc>(
      create: (context) => FavoriteBloc()
        ..add(
          FetchFavorites(
            sortColumn: TelemetryColumn.id,
            isAscending: false,
            startDate: DateTime(2000),
            endDate: DateTime.now(),
          ),
        ),
      child: BlocListener<FavoriteBloc, FavoriteState>(
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
        child: BlocBuilder<FavoriteBloc, FavoriteState>(builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () => Helper.selectDate(
                        context: context,
                        onDateRangeSelected: (startDate, endDate) {
                          context.read<FavoriteBloc>().add(
                                SetDateRange(
                                  startDate: startDate,
                                  endDate: endDate,
                                ),
                              );
                        },
                      ),
                      child: Text(
                          "${state.startDate.toLocal().toString().split(' ')[0]} - ${state.endDate.toLocal().toString().split(' ')[0]}"),
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
                              ElevatedButton(
                                onPressed: () {
                                  context
                                      .read<FavoriteBloc>()
                                      .add(UnlikeTelemetry(telemetryId: state.selectedTelemetryId));
                                },
                                child: const Icon(Icons.delete_outline),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  context.read<FavoriteBloc>().add(SelectFavorite(telemetryId: -1));
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
                child: state.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : SingleChildScrollView(
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
                          ],
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
