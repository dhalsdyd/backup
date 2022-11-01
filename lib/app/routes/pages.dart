import 'package:backup/app/pages/home/binding.dart';
import 'package:backup/app/pages/home/page.dart';
import 'package:backup/app/pages/login/page.dart';
import 'package:backup/app/pages/onboarding/view/onboarding_code.dart';
import 'package:backup/app/pages/onboarding/view/onboarding_init.dart';
import 'package:backup/app/pages/onboarding/view/onboarding_make.dart';
import 'package:backup/app/routes/route.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: Routes.home, page: () => HomePage(), binding: HomePageBinding()),
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: Routes.onboarding,
      page: () => const OnboardingInitPage(),
    ),
    GetPage(
      name: Routes.onboarding_code,
      page: () => const OnboardingCodePage(),
    ),
    GetPage(
      name: Routes.onboarding_make,
      page: () => const OnboardingMakePage(),
    ),
  ];
}
