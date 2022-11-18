import 'package:backup/app/core/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class RequestAlbumPage extends StatelessWidget {
  const RequestAlbumPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Request Album'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, size: 16),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                    "You can get real an album. Let’s make your memory more precious.",
                    style: FGBPTextTheme.text2),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/images/prepare.svg"),
                      const SizedBox(height: 16),
                      const Text("We’re preparing this service",
                          style: FGBPTextTheme.text2),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
