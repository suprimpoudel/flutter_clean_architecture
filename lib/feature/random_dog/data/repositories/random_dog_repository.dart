import 'package:flutter_clean_architecture/feature/random_dog/data/data_sources/random_dog_data_source.dart';
import 'package:flutter_clean_architecture/feature/random_dog/domain/repositories/random_dog_repository.dart';

class RandomDogRepositoryImpl implements RandomDogRepository {
  final RandomDogDataSource _dataSource;

  RandomDogRepositoryImpl(this._dataSource);

  @override
  Future<String> getRandomDogImage() async {
    try {
      return await _dataSource.getRandomDogImage();
    } catch (_) {
      rethrow;
    }
  }
}
