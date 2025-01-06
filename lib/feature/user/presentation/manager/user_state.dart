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
  final List<User> _users;

  List<User> get users => _users;

  const UserDataFetchedState(this._users);

  @override
  List<Object?> get props => [
        _users,
      ];
}

class UserAddState extends UserState {
  final User _user;

  User get user => _user;

  const UserAddState(this._user);

  @override
  List<Object?> get props => [
        _user,
      ];
}

class UserUpdateState extends UserState {
  final User _user;

  User get user => _user;

  const UserUpdateState(this._user);

  @override
  List<Object?> get props => [
        _user,
      ];
}

class UserDeleteState extends UserState {
  final int? _id;

  int? get id => _id;

  const UserDeleteState(this._id);

  @override
  List<Object?> get props => [
        _id,
      ];
}

class UserListErrorState extends UserState {
  final dynamic _error;

  dynamic get error => _error;

  const UserListErrorState(this._error);

  @override
  List<Object?> get props => [
        _error,
      ];
}

class UserErrorState extends UserState {
  final dynamic _error;

  dynamic get error => _error;

  const UserErrorState(this._error);

  @override
  List<Object?> get props => [
        _error,
      ];
}
