import 'package:backup/app/data/module/album/repository.dart';
import 'package:backup/app/data/module/album/service.dart';
import 'package:backup/app/data/provider/api.dart';
import 'package:backup/app/pages/add/controller.dart';
import 'package:get/get.dart';

class AddPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AlbumController(AlbumRepository(FGBPApiProvider())));

    Get.lazyPut<AddPageController>(() => AddPageController());
  }
}
