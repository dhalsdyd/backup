// ignore_for_file: depend_on_referenced_packages

import 'package:backup/app/data/models/category.dart';
import 'package:json_annotation/json_annotation.dart';
part 'album.g.dart';

// g.dart file generator : flutter pub run build_runner build

@JsonSerializable()
class Album {
  int id;
  @JsonKey(name: 'CategoryId')
  int? categoryId;
  String name;
  String? description;
  String? thumbnail;

  Album(
      {required this.id,
      required this.categoryId,
      required this.name,
      required this.description,
      required this.thumbnail});

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);
  Map<String, dynamic> toJson() => _$AlbumToJson(this);
}

@JsonSerializable()
class Story {
  int id;
  String image;
  String? description;
  DateTime createdAt;

  Story(
      {required this.id,
      required this.image,
      required this.description,
      required this.createdAt});

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);
  Map<String, dynamic> toJson() => _$StoryToJson(this);
}

@JsonSerializable()
class Contributor {
  int id;
  String name;
  String image;

  Contributor({required this.id, required this.name, required this.image});

  factory Contributor.fromJson(Map<String, dynamic> json) =>
      _$ContributorFromJson(json);
  Map<String, dynamic> toJson() => _$ContributorToJson(this);
}

@JsonSerializable()
class AlbumDetail {
  int id;
  DateTime createdAt;
  @JsonKey(name: 'Category')
  Category category;
  String name;
  @JsonKey(name: 'evnetDate')
  DateTime eventDate;
  String? description;
  @JsonKey(name: 'Story')
  List<Story> story;
  List<Contributor> contributors;

  AlbumDetail(
      {required this.id,
      required this.createdAt,
      required this.category,
      required this.name,
      required this.eventDate,
      required this.description,
      required this.story,
      required this.contributors});

  factory AlbumDetail.fromJson(Map<String, dynamic> json) =>
      _$AlbumDetailFromJson(json);
  Map<String, dynamic> toJson() => _$AlbumDetailToJson(this);
}
