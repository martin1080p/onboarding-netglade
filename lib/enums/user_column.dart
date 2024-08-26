import 'package:onboarding/models/user_model.dart';

enum UserColumn {
  id(position: 0, name: 'userId', label: 'ID'),
  username(position: 1, name: 'userName', label: 'Name'),
  isAdmin(position: 2, name: 'isAdmin', label: 'Is admin?'),
  isDeleted(position: 3, name: 'isDeleted', label: 'Is deleted?');

  const UserColumn({
    required this.position,
    required this.name,
    required this.label,
  });

  final int position;
  final String name;
  final String label;

  dynamic getValue(UserModel user) {
    Map<UserColumn, dynamic> map = {
      UserColumn.id: user.id,
      UserColumn.username: user.name,
      UserColumn.isAdmin: user.isAdmin,
      UserColumn.isDeleted: user.isDeleted,
    };
    return map[this];
  }
}
