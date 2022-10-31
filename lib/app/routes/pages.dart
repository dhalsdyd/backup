import 'package:backup/app/pages/home/binding.dart';
import 'package:backup/app/pages/home/page.dart';
import 'package:backup/app/pages/login/page.dart';
import 'package:backup/app/routes/route.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: Routes.home,
        page: () => const HomePage(),
        binding: HomePageBinding()),
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
    ),
  ];
}
