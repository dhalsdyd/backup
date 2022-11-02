import 'package:backup/app/data/controllers/lifecycle.dart';
import 'package:backup/app/data/provider/api.dart';
import 'package:backup/app/data/service/auth/repository.dart';
import 'package:backup/app/data/service/auth/service.dart';
import 'package:get/get.dart';

class AppInitalizer {
  Future<void> init() async {
    await Future.wait([
      Get.putAsync(() => AuthService(AuthRepository(FGBPApiProvider())).init()),
    ]);
    // await Get.putAsync<DatabaseController>(() => DatabaseController().init());
    // await Get.putAsync<AuthController>(() => AuthController().init());
  }
}
