import 'package:flutter_clean_architecture/common/utilities/constants/api_constants.dart';
import 'package:flutter_clean_architecture/common/utilities/services/base_service.dart';
import 'package:flutter_clean_architecture/feature/random_dog/data/models/random_dog.dart';

class RandomDogDataSource {
  final BaseService _baseService;

  RandomDogDataSource(this._baseService);

  Future<String> getRandomDogImage() async {
    return await _baseService.getRequest(randomDogApiEndPoint).then((value) {
      var randomDog = RandomDog.fromJson(value);
      var url = (randomDog.message ?? "").trim();
      if (url.isEmpty) {
        throw Exception("Unable to get an image. Try again");
      } else {
        return url;
      }
    });
  }
}
