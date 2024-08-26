import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding/bloc/user/user_bloc.dart';
import 'package:onboarding/bloc/user/user_event.dart';
import 'package:onboarding/bloc/user/user_state.dart';
import 'package:onboarding/enums/user_column.dart';

class UserPage extends StatelessWidget {
  UserPage({super.key});

  final List<UserColumn> columnNames = [
    UserColumn.id,
    UserColumn.username,
    UserColumn.isAdmin,
    UserColumn.isDeleted,
  ];

  void onSort(BuildContext context, UserState state, UserColumn column, bool ascending) {
    context.read<UserBloc>().add(SortUsers(sortColumn: column, isAscending: ascending));
  }

  List<DataRow> buildDataRows(BuildContext context, UserState state) {
    return state.users
        .map(
          (user) => DataRow(
              selected: user.id == state.selectedUserId,
              onSelectChanged: (selected) {
                context.read<UserBloc>().add(SelectUser(userId: user.id));
              },
              cells: [
                DataCell(Text(user.id)),
                DataCell(Text(user.name)),
                DataCell(Text(user.isAdmin.toString())),
                DataCell(Text(user.isDeleted.toString())),
              ]),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
      create: (context) => UserBloc()..add(FetchUsers()),
      child: BlocListener<UserBloc, UserState>(
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
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return Column(
              children: [
                state.selectedUserId.isNotEmpty
                    ? Column(
                        children: [
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Text(
                                  'Selected: ${state.selectedUserName}',
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const Expanded(
                                  child: SizedBox.shrink(),
                                ),
                                state.isSelectedUserAdmin
                                    ? ElevatedButton(
                                        onPressed: () {
                                          context
                                              .read<UserBloc>()
                                              .add(RemoveAdminRights(userId: state.selectedUserId));
                                        },
                                        child: const Icon(Icons.person_remove),
                                      )
                                    : ElevatedButton(
                                        onPressed: () {
                                          context
                                              .read<UserBloc>()
                                              .add(AddAdminRights(userId: state.selectedUserId));
                                        },
                                        child: const Icon(Icons.person_add),
                                      ),
                                const SizedBox(
                                  width: 8,
                                ),
                                state.isSelectedUserDeleted
                                    ? ElevatedButton(
                                        onPressed: () {
                                          context
                                              .read<UserBloc>()
                                              .add(ReinstateUser(userId: state.selectedUserId));
                                        },
                                        child: const Icon(Icons.restore),
                                      )
                                    : ElevatedButton(
                                        onPressed: () {
                                          context
                                              .read<UserBloc>()
                                              .add(DeleteUser(userId: state.selectedUserId));
                                        },
                                        child: const Icon(Icons.delete),
                                      ),
                                const SizedBox(
                                  width: 8,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    context.read<UserBloc>().add(SelectUser(userId: ''));
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
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
