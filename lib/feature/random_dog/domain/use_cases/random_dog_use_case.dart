import 'package:flutter_clean_architecture/feature/random_dog/domain/repositories/random_dog_repository.dart';

class RandomDogUseCase {
  final RandomDogRepository _repository;

  RandomDogUseCase(this._repository);

  Future<String> get getRandomDogImage async =>
      await _repository.getRandomDogImage;
}
