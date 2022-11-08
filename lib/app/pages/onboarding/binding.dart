import 'package:backup/app/pages/onboarding/controller.dart';
import 'package:get/get.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingPageController>(() => OnboardingPageController());
  }
}
