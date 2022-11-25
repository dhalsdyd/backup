import 'package:backup/app/core/theme/text_theme.dart';
import 'package:backup/app/pages/add/controller.dart';
import 'package:backup/app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectThumbnailPage extends StatelessWidget {
  SelectThumbnailPage({Key? key}) : super(key: key);

  final AddPageController controller = Get.find<AddPageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "New Album",
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
        padding: const EdgeInsets.all(35.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: controller.pickFile,
                    child: Obx(() {
                      if (controller.selectedThumbnail.value != null) {
                        return Container(
                          height: 300,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                            image: DecorationImage(
                              image: MemoryImage(controller
                                  .selectedThumbnail.value!.files.first.bytes!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }
                      return Container(
                        height: 300,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                          image: DecorationImage(
                            image: MemoryImage(controller.fileSource.bytes),
                            fit: BoxFit.cover,
                            onError: (exception, stackTrace) =>
                                AssetImage("assets/images/example.png"),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),
                  //UnderLine Text
                  GestureDetector(
                    onTap: () {
                      controller.pickFile();
                    },
                    child: Text("Or Select Other",
                        style: FGBPTextTheme.text4.copyWith(
                            color: Colors.black,
                            decoration: TextDecoration.underline)),
                  ),
                ],
              ),
            ),
            FGBPMediumTextButton(
                text: "Select Thumbnail",
                onTap: () {
                  if (controller.selectedThumbnail.value != null) {
                    Get.back(
                        result: controller
                            .selectedThumbnail.value!.files.first.bytes);
                  } else {
                    Get.back();
                  }
                }),
          ],
        ),
      )),
    );
  }
}
