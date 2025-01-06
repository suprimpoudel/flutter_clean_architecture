import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/feature/user/domain/use_cases/user_use_case.dart';
import 'package:flutter_clean_architecture/feature/user/presentation/manager/user_state.dart';
import 'package:flutter_clean_architecture/feature/user/presentation/manager/user_event.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final _limit = 20;
  int _offset = 0;

  bool _noMoreData = false;

  final UserUseCase _useCase;

  UserBloc(this._useCase) : super(UserIdleState()) {
    on<ClearAndFetchEvent>((event, emit) async {
      try {
        _noMoreData = false;
        _offset = 0;
        emit(UserClearState());
        await Future.delayed(Duration(seconds: 0));
        emit(UserListLoadingState());
        await _fetchUsers(emit);
      } catch (e) {
        emit(UserListErrorState(e));
        emit(UserIdleState());
      }
    });
    on<LoadMoreEvent>((event, emit) async {
      if (_noMoreData) {
        emit(UserIdleState());
        return;
      }

      try {
        emit(UserPaginationLoadingState());
        await _fetchUsers(emit);
      } catch (e) {
        emit(UserListErrorState(e));
        emit(UserIdleState());
      }
    });
    on<AddUpdateEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        var user = await _useCase.addUpdateUser(event.user);
        if (event.user.id == null) {
          emit(UserAddState(user));
        } else {
          emit(UserUpdateState(user));
        }
      } catch (e) {
        emit(UserErrorState(e));
        emit(UserIdleState());
      }
    });
    on<DeleteUserEvent>((event, emit) async {
      emit(UserListLoadingState());
      try {
        await _useCase.deleteUser(event.user);
        emit(UserDeleteState(event.user.id));
      } catch (e) {
        emit(UserListErrorState(e));
        emit(UserIdleState());
      }
    });
  }

  Future<void> _fetchUsers(Emitter<UserState> emit) async {
    var users = await _useCase.getUsers(_limit, _offset);
    _offset = _offset + _limit;
    _noMoreData = users.length < _limit;
    emit(UserDataFetchedState(users));
  }
}
