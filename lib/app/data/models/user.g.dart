// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Family _$FamilyFromJson(Map<String, dynamic> json) => Family(
      name: json['name'] as String,
      memberCount: json['memberCount'] as int,
    );

Map<String, dynamic> _$FamilyToJson(Family instance) => <String, dynamic>{
      'name': instance.name,
      'memberCount': instance.memberCount,
    };

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      name: json['name'] as String,
      picture: json['picture'] as String,
      family: json['family'] == null
          ? null
          : Family.fromJson(json['family'] as Map<String, dynamic>),
    )..id = json['id'] as int?;

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'picture': instance.picture,
      'family': instance.family,
    };

Member _$MemberFromJson(Map<String, dynamic> json) => Member(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      picture: json['picture'] as String,
    );

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'picture': instance.picture,
    };
