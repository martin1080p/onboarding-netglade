import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding/bloc/error/error_bloc.dart';
import 'package:onboarding/bloc/error/error_event.dart';
import 'package:onboarding/bloc/error/error_state.dart';
import 'package:onboarding/enums/error_column.dart';
import 'package:onboarding/repositories/auth_repository.dart';

class ErrorPage extends StatelessWidget {
  ErrorPage({super.key});

  final ScrollController _scrollController = ScrollController();
  final _isAdmin = AuthRepository.i.user.isAdmin;

  final List<ErrorColumn> columnNames = [
    ErrorColumn.id,
    ErrorColumn.timestamp,
    ErrorColumn.dataBytes,
    ErrorColumn.dataString,
  ];

  void onScroll(BuildContext context, ErrorState state) {
    if (state.hasReachedMax || state.isLoading || !context.mounted) {
      return;
    }

    if ((_scrollController.positions.isEmpty && state.page < 1) ||
        (_scrollController.positions.isEmpty && state.errors.isNotEmpty) ||
        (_scrollController.positions.isNotEmpty &&
            _scrollController.position.pixels == _scrollController.position.maxScrollExtent)) {
      context.read<ErrorBloc>().add(FetchError());
    }
  }

  List<DataRow> buildDataRows(BuildContext context, ErrorState state) {
    return state.errors
        .map(
          (error) => DataRow(
              selected: error.id == state.selectedErrorId,
              onSelectChanged: _isAdmin
                  ? (selected) {
                      context.read<ErrorBloc>().add(SelectError(errorId: error.id));
                    }
                  : null,
              cells: [
                DataCell(Text(error.id.toString())),
                DataCell(Text(DateTime.fromMillisecondsSinceEpoch(error.timestamp * 1000)
                    .toLocal()
                    .toString())),
                DataCell(Text(error.dataBytes.join(', '))),
                DataCell(Text(error.originalString)),
              ]),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ErrorBloc>(
      create: (context) => ErrorBloc()..add(FetchError()),
      child: BlocListener<ErrorBloc, ErrorState>(
        listener: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
              ),
            );
          }
        },
        child: BlocBuilder<ErrorBloc, ErrorState>(
          builder: (context, state) {
            onScroll(context, state);
            return Column(
              children: [
                state.selectedErrorId != -1
                    ? Column(
                        children: [
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Text('Selected: ${state.selectedErrorId}'),
                                const Expanded(
                                  child: SizedBox.shrink(),
                                ),
                                _isAdmin
                                    ? ElevatedButton(
                                        onPressed: () {
                                          context
                                              .read<ErrorBloc>()
                                              .add(DeleteError(errorId: state.selectedErrorId));
                                        },
                                        child: const Icon(Icons.delete_outline),
                                      )
                                    : const SizedBox.shrink(),
                                const SizedBox(
                                  width: 8,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    context.read<ErrorBloc>().add(SelectError(errorId: -1));
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
                  child: state.isLoading && state.errors.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : NotificationListener(
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
                                Center(
                                  child: state.isRefreshing
                                      ? const LinearProgressIndicator()
                                      : const SizedBox(
                                          height: 4,
                                        ),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                    columns: columnNames
                                        .map((column) => DataColumn(
                                              label: Text(column.label),
                                            ))
                                        .toList(),
                                    rows: buildDataRows(context, state),
                                  ),
                                ),
                                Center(
                                  child: state.isLoading && state.errors.isNotEmpty
                                      ? const LinearProgressIndicator()
                                      : const SizedBox(
                                          height: 4,
                                        ),
                                )
                              ],
                            ),
                          ),
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
