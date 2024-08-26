import 'package:onboarding/enums/user_column.dart';

class UserEvent {}

class FetchUsers extends UserEvent {}

class SortUsers extends UserEvent {
  final UserColumn sortColumn;
  final bool isAscending;

  SortUsers({
    required this.sortColumn,
    required this.isAscending,
  });
}

class SelectUser extends UserEvent {
  final String userId;

  SelectUser({
    required this.userId,
  });
}

class ReinstateUser extends UserEvent {
  final String userId;

  ReinstateUser({
    required this.userId,
  });
}

class DeleteUser extends UserEvent {
  final String userId;

  DeleteUser({
    required this.userId,
  });
}

class AddAdminRights extends UserEvent {
  final String userId;

  AddAdminRights({
    required this.userId,
  });
}

class RemoveAdminRights extends UserEvent {
  final String userId;

  RemoveAdminRights({
    required this.userId,
  });
}
