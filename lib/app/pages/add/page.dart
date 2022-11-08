import 'dart:io';

import 'package:backup/app/core/theme/text_theme.dart';
import 'package:backup/app/pages/add/controller.dart';
import 'package:backup/app/widgets/button.dart';
import 'package:backup/app/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPage extends StatelessWidget {
  AddPage({Key? key}) : super(key: key);

  final AddPageController controller = Get.find<AddPageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Name Your Image",
          style: FGBPTextTheme.text4Bold,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(35),
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: GetPlatform.isWeb
                    ? Image.memory(controller.fileSource.bytes,
                        fit: BoxFit.cover)
                    : Image.file(File(controller.fileSource.path),
                        fit: BoxFit.cover),
              ),
              const SizedBox(height: 20),
              FGBPTextField(controller: controller.nameController),
              const SizedBox(height: 20),
              FGBPMediumTextButton(
                  text: "Next", onTap: controller.enterImageName),
            ],
          ),
        ),
      ),
    );
  }
}
