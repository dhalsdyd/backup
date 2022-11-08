import 'package:backup/app/core/middleware/login.dart';
import 'package:backup/app/pages/add/binding.dart';
import 'package:backup/app/pages/add/page.dart';
import 'package:backup/app/pages/home/binding.dart';
import 'package:backup/app/pages/home/page.dart';
import 'package:backup/app/pages/login/page.dart';
import 'package:backup/app/pages/onboarding/binding.dart';
import 'package:backup/app/pages/onboarding/view/onboarding_code.dart';
import 'package:backup/app/pages/onboarding/view/onboarding_init.dart';
import 'package:backup/app/pages/onboarding/view/onboarding_make.dart';
import 'package:backup/app/routes/route.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: Routes.home,
        page: () => const HomePage(),
        binding: HomePageBinding(),
        middlewares: [LoginMiddleware()]),
    GetPage(
      name: Routes.login,
      page: () => LoginPage(),
    ),
    GetPage(
      name: Routes.add,
      page: () => AddPage(),
      binding: AddPageBinding(),
    ),
    GetPage(
      name: Routes.onboarding,
      page: () => OnboardingInitPage(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: Routes.onboarding_code,
      page: () => OnboardingCodePage(),
    ),
    GetPage(
      name: Routes.onboarding_make,
      page: () => OnboardingMakePage(),
    ),
  ];
}
