// ignore_for_file: depend_on_referenced_packages

import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

// g.dart file generator : flutter pub run build_runner build

@JsonSerializable()
class Family {
  String name;
  int memberCount;

  Family({required this.name, required this.memberCount});

  factory Family.fromJson(Map<String, dynamic> json) => _$FamilyFromJson(json);
  Map<String, dynamic> toJson() => _$FamilyToJson(this);
}

@JsonSerializable()
class Profile {
  int? id;
  String name;
  String picture;
  Family? family;

  Profile({required this.name, required this.picture, required this.family});

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}

@JsonSerializable()
class Member {
  int id;
  String name;
  String email;
  String picture;

  Member(
      {required this.id,
      required this.name,
      required this.email,
      required this.picture});

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);
  Map<String, dynamic> toJson() => _$MemberToJson(this);
}
