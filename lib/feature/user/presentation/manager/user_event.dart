import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/feature/user/data/models/user.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class ClearAndFetchEvent extends UserEvent {}

class LoadMoreEvent extends UserEvent {}

class AddUpdateEvent extends UserEvent {
  final User user;

  const AddUpdateEvent(this.user);
}

class DeleteUserEvent extends UserEvent {
  final User user;

  const DeleteUserEvent(this.user);
}
