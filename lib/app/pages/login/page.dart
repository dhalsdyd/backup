import 'package:backup/app/core/theme/color_theme.dart';
import 'package:backup/app/core/theme/text_theme.dart';
import 'package:backup/app/data/service/auth/service.dart';
import 'package:backup/app/routes/route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final AuthService authService = Get.find<AuthService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(44),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/images/login.svg"),
                  const SizedBox(height: 12),
                  const Text("BackUP", style: FGBPTextTheme.logo),
                  const SizedBox(height: 12),
                  Text("Let’s save your Family memory",
                      style: FGBPTextTheme.head2
                          .copyWith(color: FGBPColors.Black3)),
                ],
              ),
            ),
            GestureDetector(
              onTap: () async {
                await authService.loginWithGoogle();

                if (authService.isFirstVisit) {
                  Get.offAllNamed(Routes.onboarding);
                } else {
                  // check dialog
                  if (GetPlatform.isAndroid || GetPlatform.isWeb) {
                    Get.dialog(AlertDialog(
                      title: const Text("Notice"),
                      // 온보딩을 새로 하시면 기존 데이터가 삭제됩니다.
                      content: const Text(
                          "If you do onboarding again, your existing data will be deleted."),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Get.offAllNamed(Routes.onboarding);
                          },
                          child: const Text("Onboarding"),
                        ),
                        // Go HOME
                        TextButton(
                          onPressed: () {
                            Get.offAllNamed(Routes.home);
                          },
                          child: const Text("Home"),
                        ),
                      ],
                    ));
                  } else if (GetPlatform.isIOS) {
                    Get.dialog(CupertinoAlertDialog(
                      title: const Text("Notice"),
                      // 온보딩을 새로 하시면 기존 데이터가 삭제됩니다.
                      content: const Text(
                          "If you do onboarding again, your existing data will be deleted."),
                      actions: [
                        CupertinoDialogAction(
                          onPressed: () {
                            Get.offAllNamed(Routes.onboarding);
                          },
                          child: const Text("Onboarding"),
                        ),
                        // Go HOME
                        CupertinoDialogAction(
                          onPressed: () {
                            Get.offAllNamed(Routes.home);
                          },
                          child: const Text("home"),
                        ),
                      ],
                    ));
                  }
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: const Offset(0, 4), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/images/google.svg"),
                      const SizedBox(width: 12),
                      Text("Login With Google",
                          style: FGBPTextTheme.text4Bold.copyWith(
                              color: FGBPColors.Black3,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
