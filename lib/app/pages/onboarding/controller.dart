import 'package:backup/app/data/service/auth/service.dart';
import 'package:backup/app/routes/route.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OnboardingPageController extends GetxController with StateMixin {
  final AuthService authService = Get.find<AuthService>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final Rx<String?> name = Rx(null);
  bool get inputValidity => name.value != null && name.value!.isNotEmpty;

  @override
  onInit() {
    super.onInit();
    nameController.addListener(() {
      name.value = nameController.text;
    });
    change(null, status: RxStatus.success());
  }

  Future<void> enterName() async {
    change(null, status: RxStatus.loading());
    try {
      await authService.enterName(nameController.text);
      nameController.text = "";
      change(null, status: RxStatus.success());
      Get.toNamed(Routes.onboarding_code);
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  Future<void> enterFamily(String code) async {
    change(null, status: RxStatus.loading());
    try {
      await authService.enterFamily(pinController.text);
      pinController.text = "";
      change(null, status: RxStatus.success());
      Get.offAllNamed(Routes.home);
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  Future<void> createFamily() async {
    change(null, status: RxStatus.loading());
    try {
      await authService.createFamily(nameController.text);
      nameController.text = "";
      change(null, status: RxStatus.success());
      Get.toNamed(Routes.home);
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
