import 'dart:async';

import 'package:backup/app/core/theme/text_theme.dart';
import 'package:backup/app/data/models/user.dart';
import 'package:backup/app/data/module/profile/service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FamilyCodePage extends StatelessWidget {
  FamilyCodePage({Key? key}) : super(key: key);

  final ProfileController controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Family Code",
          style: FGBPTextTheme.text4Bold,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Obx(
                () => Column(
                  children: [
                    Text(
                      controller.familyCode.value ?? "Loading...",
                      style: FGBPTextTheme.text2Bold,
                    ),
                    Text(
                      "Left Time: ${controller.refreshTimer?.tick ?? 0}",
                      style: FGBPTextTheme.text2Bold,
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                controller.getFamilyCode();
              },
              child: const Text("getFamilyCode"),
            ),
            //left Time
          ],
        ),
      ),
    );
  }
}
