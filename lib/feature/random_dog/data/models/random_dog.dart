import 'package:json_annotation/json_annotation.dart';

part 'random_dog.g.dart';

@JsonSerializable()
class RandomDog {
  final String? success;
  final String? message;

  RandomDog({this.success, this.message});

  factory RandomDog.fromJson(Map<String, dynamic> map) =>
      _$RandomDogFromJson(map);

  Map<String, dynamic> toJson() => _$RandomDogToJson(this);
}
