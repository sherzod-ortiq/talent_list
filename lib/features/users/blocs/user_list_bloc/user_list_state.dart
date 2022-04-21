part of './user_list_bloc.dart';

enum UserListLoadStatus { initial, success, failure }

class UserListState extends Equatable {
  const UserListState({
    this.loadStatus = UserListLoadStatus.initial,
    this.users = const <User>[],
    this.hasReachedMax = false,
  });

  final UserListLoadStatus loadStatus;
  final List<User> users;
  final bool hasReachedMax;

  UserListState copyWith({
    UserListLoadStatus? loadStatus,
    List<User>? users,
    bool? hasReachedMax,
  }) {
    return UserListState(
      loadStatus: loadStatus ?? this.loadStatus,
      users: users ?? this.users,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [loadStatus, users, hasReachedMax];
}
