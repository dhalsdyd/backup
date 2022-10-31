import 'package:backup/app/pages/home/binding.dart';
import 'package:backup/app/pages/home/page.dart';
import 'package:backup/app/pages/login/page.dart';
import 'package:backup/app/pages/register/view/register_code.dart';
import 'package:backup/app/pages/register/view/register_init.dart';
import 'package:backup/app/routes/route.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: Routes.home,
        page: () =>  HomePage(),
        binding: HomePageBinding()),
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: Routes.register,
      page: () => const RegisterInitPage(),
    ),
    GetPage(
      name: Routes.register_code,
      page: () => const RegisterCodePage(),
    ),
  ];
}
