import 'package:flutter_clean_architecture/feature/random_dog/data/data_sources/random_dog_data_source.dart';
import 'package:flutter_clean_architecture/feature/random_dog/domain/repositories/random_dog_repository.dart';

class RandomDogRepositoryImpl implements RandomDogRepository {
  final RandomDogDataSource _dataSource;

  RandomDogRepositoryImpl(this._dataSource);

  @override
  Future<String> get getRandomDogImage async {
    return await _dataSource.getRandomDogImage.then((value) {
      var url = (value.message ?? "").trim();
      if (url.isEmpty) {
        throw Exception("Unable to get an image. Try again");
      } else {
        return url;
      }
    });
  }
}
