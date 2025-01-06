import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/common/data/models/base_mapper.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable with BaseMapper {
  final int? id;
  final String? firstName, lastName, emailAddress, phoneNumber;

  const User({
    this.id,
    this.firstName,
    this.lastName,
    this.emailAddress,
    this.phoneNumber,
  });

  factory User.fromMap(Map<String, dynamic> map) => _$UserFromJson(map);

  User copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? emailAddress,
    String? phoneNumber,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      emailAddress: emailAddress ?? this.emailAddress,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  @override
  Map<String, dynamic> toMap() => _$UserToJson(this);

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        emailAddress,
        phoneNumber,
      ];
}
