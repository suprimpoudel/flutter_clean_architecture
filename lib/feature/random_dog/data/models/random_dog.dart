import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'random_dog.g.dart';

@JsonSerializable()
class RandomDog extends Equatable {
  final String? success;
  final String? message;

  const RandomDog({this.success, this.message});

  factory RandomDog.fromJson(Map<String, dynamic> map) =>
      _$RandomDogFromJson(map);

  Map<String, dynamic> toJson() => _$RandomDogToJson(this);

  @override
  List<Object?> get props => [
        success,
        message,
      ];
}
