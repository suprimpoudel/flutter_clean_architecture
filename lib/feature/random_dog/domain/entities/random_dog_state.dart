import 'package:equatable/equatable.dart';

abstract class RandomDogState extends Equatable {
  const RandomDogState();

  @override
  List<Object?> get props => [];
}

class RandomDogIdleState extends RandomDogState {}

class RandomDogLoadingState extends RandomDogState {}

class RandomDogErrorState extends RandomDogState {
  final dynamic error;

  const RandomDogErrorState(this.error);
}

class RandomDogFetchedState extends RandomDogState {
  final String randomDog;

  const RandomDogFetchedState(this.randomDog);
}
