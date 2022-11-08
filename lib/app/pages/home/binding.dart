import 'package:backup/app/data/module/album/repository.dart';
import 'package:backup/app/data/module/album/service.dart';
import 'package:backup/app/data/module/category/repository.dart';
import 'package:backup/app/data/module/category/service.dart';
import 'package:backup/app/data/module/profile/repository.dart';
import 'package:backup/app/data/module/profile/service.dart';
import 'package:backup/app/data/provider/api.dart';
import 'package:backup/app/pages/home/controller.dart';
import 'package:get/get.dart';

class HomePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomePageController>(() => HomePageController());
    Get.lazyPut(
        () => CategoryController(CategoryRepository(FGBPApiProvider())));
    Get.lazyPut(() => AlbumController(AlbumRepository(FGBPApiProvider())));
    Get.lazyPut(() => ProfileController(ProfileRepository(FGBPApiProvider())));
  }
}
