// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Album _$AlbumFromJson(Map<String, dynamic> json) => Album(
      id: json['id'] as int,
      categoryId: json['CategoryId'] as int?,
      name: json['name'] as String,
      description: json['description'] as String?,
      thumbnail: json['thumbnail'] as String?,
    );

Map<String, dynamic> _$AlbumToJson(Album instance) => <String, dynamic>{
      'id': instance.id,
      'CategoryId': instance.categoryId,
      'name': instance.name,
      'description': instance.description,
      'thumbnail': instance.thumbnail,
    };

Story _$StoryFromJson(Map<String, dynamic> json) => Story(
      id: json['id'] as int,
      image: json['image'] as String,
      description: json['description'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$StoryToJson(Story instance) => <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'description': instance.description,
      'createdAt': instance.createdAt.toIso8601String(),
    };

Contributor _$ContributorFromJson(Map<String, dynamic> json) => Contributor(
      id: json['id'] as int,
      name: json['name'] as String,
      picture: json['picture'] as String,
    );

Map<String, dynamic> _$ContributorToJson(Contributor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'picture': instance.picture,
    };

AlbumDetail _$AlbumDetailFromJson(Map<String, dynamic> json) => AlbumDetail(
      id: json['id'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      category: Category.fromJson(json['Category'] as Map<String, dynamic>),
      name: json['name'] as String,
      eventDate: DateTime.parse(json['evnetDate'] as String),
      description: json['description'] as String?,
      story: (json['Story'] as List<dynamic>)
          .map((e) => Story.fromJson(e as Map<String, dynamic>))
          .toList(),
      contributors: (json['contributors'] as List<dynamic>)
          .map((e) => Contributor.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AlbumDetailToJson(AlbumDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'Category': instance.category,
      'name': instance.name,
      'evnetDate': instance.eventDate.toIso8601String(),
      'description': instance.description,
      'Story': instance.story,
      'contributors': instance.contributors,
    };
