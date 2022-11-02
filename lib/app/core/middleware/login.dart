import 'package:backup/app/data/service/auth/service.dart';
import 'package:backup/app/routes/route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginMiddleware extends GetMiddleware {
  final AuthService authService = Get.find<AuthService>();

  LoginMiddleware({super.priority});

  @override
  RouteSettings? redirect(String? route) {
    return authService.isAuthenticated
        ? null
        : RouteSettings(name: Routes.home, arguments: {'redirect': route});
  }
}
