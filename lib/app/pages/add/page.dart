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
        title: const Text(
          "Name Your Image",
          style: FGBPTextTheme.text4Bold,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 16),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 35, right: 35, bottom: 16),
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset:
                            const Offset(0, 4), // changes position of shadow
                      ),
                    ],
                  ),
                  child: _imageOrVideo(),
                ),
              ),
              const SizedBox(height: 20),
              FGBPTextField(
                hintText: "Image Name",
                controller: controller.nameController,
              ),
              const SizedBox(height: 20),
              FGBPMediumTextButton(
                  text: "Next", onTap: controller.enterImageName),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imageOrVideo() {
    if (controller.fileSource.isImage) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.memory(
          controller.fileSource.bytes,
          fit: BoxFit.cover,
        ),
      );
    }

    //동영상 미리보기는 지원하지 않습니다.
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          "Video Preview is not supported",
          style: FGBPTextTheme.text3Bold.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
