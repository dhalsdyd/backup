import 'package:backup/app/data/models/album.dart';
import 'package:backup/app/data/provider/api_interface.dart';
import 'package:backup/app/pages/home/controller.dart';

class AlbumRepository {
  final FGBPApiInterface api;
  AlbumRepository(this.api);

  Future<List<Album>> getAlbums(String type) => api.getAlbums(type: type);
  Future<TodayStory> todayStory() => api.getTodayStory();
  Future<AlbumDetail> getAlbumDetails(int albumId) =>
      api.getAlbumDetails(albumId);
  Future<void> createAlbum(String name, String description, String? date,
          int? categoryId, String? revealDate, String? thumbnail) =>
      api.createAlbum(
          name, description, categoryId, date, revealDate, thumbnail);

  Future<String> uploadFile(
          FileSource fileSource, Function(int, int)? onSendProgress) =>
      api.uploadFile(fileSource, onSendProgress);
  Future<void> createStory(int albumId, String? description, String imageKey) =>
      api.createStory(albumId, description, imageKey);
}
