import 'dart:typed_data';

import 'package:backup/app/core/theme/color_theme.dart';
import 'package:backup/app/core/theme/text_theme.dart';
import 'package:backup/app/data/module/album/service.dart';
import 'package:backup/app/pages/add/view/thumbnail.dart';
import 'package:backup/app/pages/home/controller.dart';
import 'package:backup/app/widgets/button.dart';
import 'package:backup/app/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MakeCapsulePage extends StatelessWidget {
  MakeCapsulePage({Key? key}) : super(key: key);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  void selectDate() async {
    DateTime now = DateTime.now();

    DateTime? result = await showDatePicker(
        context: Get.overlayContext!,
        initialEntryMode: DatePickerEntryMode.calendar,
        initialDate: now,
        currentDate: now,
        firstDate: DateTime(1900),
        lastDate: DateTime(DateTime.now().year, 12, 31));
    if (result != null) {
      _dateController.text = result.toIso8601String();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "New Capsule",
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
          padding: const EdgeInsets.only(left: 35, right: 35, bottom: 35),
          child: Column(children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Name", style: FGBPTextTheme.head4),
                    FGBPTextFormField(
                      hintText: "Capsule Name",
                      controller: _nameController,
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 50),
                    const Text("Description (Optional)",
                        style: FGBPTextTheme.head4),
                    FGBPTextFormField(
                      controller: _descriptionController,
                      hintText: "Capsule Description",
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 50),
                    const Text("Reveal Date", style: FGBPTextTheme.head4),
                    FGBPTextFormField(
                      hintText: "Reveal Date",
                      controller: _dateController,
                      readOnly: true,
                      onTap: selectDate,
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),
            ),
            FGBPKeyboardReactiveButton(
              onTap: () async {
                final Uint8List? thumbnailData =
                    await Get.to(() => SelectThumbnailPage());
                String? thumbnailId = null;
                if (thumbnailData == null) {
                } else {
                  FileSource thumbnailFileSource = FileSource(
                      name: "thumbnailData",
                      bytes: thumbnailData,
                      path: "thumbnailData",
                      isImage: true);
                  thumbnailId = await Get.find<AlbumController>().uploadFile(
                      thumbnailFileSource, "thumbnailData", (p0, p1) => null);
                }

                await Get.find<AlbumController>().createAlbum(
                    _nameController.text,
                    _descriptionController.text,
                    null,
                    null,
                    _dateController.text,
                    thumbnailId);
                Get.back();
              },
              child: Text(
                "Next",
                style: FGBPTextTheme.text2Bold.copyWith(
                  color: FGBPColors.White1,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
