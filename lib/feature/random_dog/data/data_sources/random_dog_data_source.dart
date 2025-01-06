import 'package:flutter_clean_architecture/common/utilities/constants/api_constants.dart';
import 'package:flutter_clean_architecture/common/utilities/helpers/api_helper.dart';
import 'package:flutter_clean_architecture/feature/random_dog/data/models/random_dog.dart';

class RandomDogDataSource {
  final ApiHelper _baseService;

  RandomDogDataSource(this._baseService);

  Future<RandomDog> get getRandomDogImage async =>
      await _baseService.getRequest(randomDogApiEndPoint).then((value) {
        return RandomDog.fromJson(value);
      });
}
