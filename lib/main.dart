import 'package:backup/app/routes/pages.dart';
import 'package:backup/app/routes/route.dart';
import 'package:backup/app/translation/translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
//import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:backup/app/data/initalize.dart';

Future<void> main() async {
  //WidgetsBinding widgetsBinding =
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await AppInitalizer().init();
  FlutterNativeSplash.remove();

  // Do Firebase Initial Settings With Firebase CLIx
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //Get.config();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      //unknownRoute: GetPage(name: '/notfound', page: () => UnknownRoutePage()),
      initialRoute: Routes.home,
      getPages: AppPages.pages,
      theme: ThemeData(
        fontFamily: "Pretendard",
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      locale: GetCurrentLocale.currentDeviceLocale,
      fallbackLocale: GetCurrentLocale.fallBackLocale,
      //routingCallback
      //GetObserver
    ),
  );
}
