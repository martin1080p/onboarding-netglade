import 'package:equatable/equatable.dart';
import 'package:onboarding/enums/user_column.dart';
import 'package:onboarding/models/user_model.dart';

class UserState extends Equatable {
  final UserColumn sortColumn;
  final bool isAscending;
  final String selectedUserId;
  final List<UserModel> users;
  final String errorMessage;
  final bool isLoading;

  const UserState({
    this.sortColumn = UserColumn.username,
    this.isAscending = true,
    this.selectedUserId = '',
    this.users = const [],
    this.errorMessage = '',
    this.isLoading = false,
  });

  bool get isSelectedUserAdmin => users.firstWhere((user) => user.id == selectedUserId).isAdmin;
  bool get isSelectedUserDeleted => users.firstWhere((user) => user.id == selectedUserId).isDeleted;
  String? get selectedUserName => users.firstWhere((user) => user.id == selectedUserId).name;

  UserState copyWith({
    UserColumn? sortColumn,
    bool? isAscending,
    String? selectedUserId,
    List<UserModel>? users,
    String? errorMessage,
    bool? isLoading,
  }) {
    return UserState(
      sortColumn: sortColumn ?? this.sortColumn,
      isAscending: isAscending ?? this.isAscending,
      selectedUserId: selectedUserId ?? this.selectedUserId,
      users: users ?? this.users,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [
        sortColumn,
        isAscending,
        selectedUserId,
        users,
        errorMessage,
        isLoading,
      ];
}
