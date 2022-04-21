import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

import 'package:talent_list/features/users/models/user.dart';

part './user_list_event.dart';
part './user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  UserListBloc() : super(const UserListInitial());

  @override
  Stream<UserListState> mapEventToState(
    UserListEvent event,
  ) async* {
    if (event is UserListLoaded) {
      yield* _mapUserListLoadedToState();
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }

  Stream<UserListState> _mapUserListLoadedToState() async* {
    List<User> users = state.users;

    if (taskBlocs.isEmpty) {
      User task = User(
        id: const Uuid().v4(),
        taskStatus: 'Новая',
        shortDescr: 'Короткое описание',
        descr: 'Подробное описание задачи',
        createdAt: DateTime.now(),
      );

      taskBlocs = [UserBloc(task: task)];
    }

    yield UserListUpdate(taskBlocs);
    return;
  }
}
