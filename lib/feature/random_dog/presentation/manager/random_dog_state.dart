import 'package:equatable/equatable.dart';

abstract class RandomDogState extends Equatable {
  const RandomDogState();

  @override
  List<Object?> get props => [];
}

class RandomDogIdleState extends RandomDogState {}

class RandomDogLoadingState extends RandomDogState {}

class RandomDogErrorState extends RandomDogState {
  final dynamic _error;

  dynamic get error => _error;

  const RandomDogErrorState(this._error);

  @override
  List<Object?> get props => [
        _error,
      ];
}

class RandomDogFetchedState extends RandomDogState {
  final String _randomDog;

  String get randomDog => _randomDog;

  const RandomDogFetchedState(this._randomDog);

  @override
  List<Object?> get props => [
        _randomDog,
      ];
}
