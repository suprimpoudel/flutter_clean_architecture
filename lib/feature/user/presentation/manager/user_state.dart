import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/feature/user/data/models/user.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserIdleState extends UserState {}

class UserListLoadingState extends UserState {}

class UserLoadingState extends UserState {}

class UserPaginationLoadingState extends UserState {}

class UserClearState extends UserState {}

class UserDataFetchedState extends UserState {
  final List<User> users;

  const UserDataFetchedState(this.users);
}

class UserAddState extends UserState {
  final User user;

  const UserAddState(this.user);
}

class UserUpdateState extends UserState {
  final User user;

  const UserUpdateState(this.user);
}

class UserDeleteState extends UserState {
  final int? id;

  const UserDeleteState(this.id);
}

class UserListErrorState extends UserState {
  final dynamic error;

  const UserListErrorState(this.error);
}

class UserErrorState extends UserState {
  final dynamic error;

  const UserErrorState(this.error);
}
