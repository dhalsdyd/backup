import 'package:backup/app/data/models/album.dart';
import 'package:backup/app/data/module/album/repository.dart';
import 'package:backup/app/pages/home/controller.dart';
import 'package:backup/app/widgets/snackbar.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class AlbumController extends GetxController {
  final AlbumRepository repository;
  AlbumController(this.repository);

  final RxList<Album> _albums = <Album>[].obs;
  List<Album> get albums => _albums;

  final RxList<Album> _capsules = <Album>[].obs;
  List<Album> get capsules => _capsules;

  final Rx<TodayStory?> _todayStory = Rx(null);
  TodayStory? get todayStory => _todayStory.value;

  @override
  void onInit() async {
    super.onInit();
    try {
      _albums.value = await repository.getAlbums("album");
      _capsules.value = await repository.getAlbums("capsule");
      _todayStory.value = await repository.todayStory();
    } on DioError catch (e) {
      //print(e.response!.data);
      FGBPSnackBar.open(e.message);
    }
  }

  Future<TodayStory> getTodayStory() async {
    try {
      _todayStory.value = await repository.todayStory();
      return _todayStory.value!;
    } on DioError catch (e) {
      //print(e.response!.data);
      FGBPSnackBar.open(e.message);
      throw e;
    }
  }

  Future<List<Album>> getAlbums({String type = "album"}) async {
    _albums.value = await repository.getAlbums(type);
    return _albums;
  }

  Future<AlbumDetail> getAlbumDetail(int id) async {
    try {
      return await repository.getAlbumDetails(id);
    } on DioError catch (e) {
      FGBPSnackBar.open(e.message);
      print(e.response!.data);
      throw e;
    }
  }

  Future<void> createAlbum(String name, String description, String? date,
      int? categoryId, String? revealDate, String? thumbnail) async {
    try {
      await repository.createAlbum(
          name, description, date, categoryId, revealDate, thumbnail);
    } on DioError catch (e) {
      print(e.response!.data);
      return;
    }
    _albums.value = await repository.getAlbums("album");
    _capsules.value = await repository.getAlbums("capsule");
  }

  Future<String> uploadFile(FileSource fileSource, String? name,
      Function(int, int)? onSendProgress) async {
    try {
      if (name != null) {
        fileSource.name = name;
      }

      String key = await repository.uploadFile(fileSource, onSendProgress);
      return key;
    } on DioError catch (_) {
      print(_.response!.data);
      rethrow;
    }
  }

  Future<void> addImageToAlbum(
      int albumId, String? description, String imageKey) async {
    try {
      await repository.createStory(albumId, description, imageKey);
    } on DioError catch (_) {
      //print(e.message);
      rethrow;
    }
  }
}
