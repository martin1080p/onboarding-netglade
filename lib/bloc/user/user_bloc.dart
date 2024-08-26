import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding/bloc/user/user_event.dart';
import 'package:onboarding/bloc/user/user_state.dart';
import 'package:onboarding/helpers/helper.dart';
import 'package:onboarding/repositories/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserState()) {
    on<FetchUsers>(onFetchUsers);
    on<SortUsers>(onSortUsers);
    on<SelectUser>(onSelectUser);
    on<DeleteUser>(onDeleteUser);
    on<ReinstateUser>(onReinstateUser);
    on<AddAdminRights>(onAddAdminRights);
    on<RemoveAdminRights>(onRemoveAdminRights);
  }

  void onFetchUsers(FetchUsers event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final users = await UserRepository.i.getUsers();
      final sortedUsers = Helper.sortUsers(users, state.sortColumn.getValue, state.isAscending);
      emit(state.copyWith(users: sortedUsers, isLoading: false));
    } catch (e) {
      _emitError(emit, "Failed to fetch users");
    }
  }

  void onSortUsers(SortUsers event, Emitter<UserState> emit) {
    final sortedUsers = Helper.sortUsers(state.users, event.sortColumn.getValue, event.isAscending);
    emit(state.copyWith(
        users: sortedUsers, sortColumn: event.sortColumn, isAscending: event.isAscending));
  }

  void onSelectUser(SelectUser event, Emitter<UserState> emit) {
    emit(state.copyWith(selectedUserId: event.userId));
  }

  void onDeleteUser(DeleteUser event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true, selectedUserId: ''));
    try {
      await UserRepository.i.deleteUser(event.userId);
    } catch (e) {
      _emitError(emit, "Failed to delete user");
    }

    add(FetchUsers());
  }

  void onReinstateUser(ReinstateUser event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true, selectedUserId: ''));
    try {
      await UserRepository.i.reinstateUser(event.userId);
    } catch (e) {
      _emitError(emit, "Failed to reinstate user");
    }

    add(FetchUsers());
  }

  void onAddAdminRights(AddAdminRights event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true, selectedUserId: ''));
    try {
      await UserRepository.i.addAdminRights(event.userId);
    } catch (e) {
      _emitError(emit, "Failed to add admin rights");
    }

    add(FetchUsers());
  }

  void onRemoveAdminRights(RemoveAdminRights event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true, selectedUserId: ''));
    try {
      await UserRepository.i.removeAdminRights(event.userId);
    } catch (e) {
      _emitError(emit, "Failed to remove admin rights");
    }

    add(FetchUsers());
  }

  void _emitError(Emitter<UserState> emit, String errorMessage) {
    emit(state.copyWith(errorMessage: errorMessage, isLoading: false));
  }
}
