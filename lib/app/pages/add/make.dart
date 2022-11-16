import 'package:backup/app/core/theme/color_theme.dart';
import 'package:backup/app/core/theme/text_theme.dart';
import 'package:backup/app/pages/add/controller.dart';
import 'package:backup/app/widgets/button.dart';
import 'package:backup/app/widgets/dropdown.dart';
import 'package:backup/app/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MakeAlbumPage extends StatelessWidget {
  MakeAlbumPage({Key? key}) : super(key: key);

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
          padding: const EdgeInsets.only(left: 35, right: 35, bottom: 35),
          child: Column(
            children: [
              GestureDetector(
                onTap: controller.autoGenerateAlbum,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: FGBPColors.Black4),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 0,
                        blurRadius: 10,
                        offset:
                            const Offset(0, 4), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text("+ Auto Generate Album",
                          style: FGBPTextTheme.text2Bold.copyWith(
                              color: FGBPColors.Black2,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Name", style: FGBPTextTheme.head4),
                      FGBPTextFormField(
                        hintText: "Album Name",
                        controller: controller.nameController,
                        onChanged: (value) {},
                      ),
                      const SizedBox(height: 50),
                      const Text("Description (Optional)",
                          style: FGBPTextTheme.head4),
                      FGBPTextFormField(
                        controller: controller.descriptionController,
                        hintText: "Album Description",
                        onChanged: (value) {},
                      ),
                      const SizedBox(height: 50),
                      const Text("Date", style: FGBPTextTheme.head4),
                      FGBPTextFormField(
                        hintText: "Album Date",
                        controller: controller.dateController,
                        readOnly: true,
                        onTap: controller.selectDate,
                        onChanged: (value) {},
                      ),
                      const SizedBox(height: 50),
                      const Text("Category", style: FGBPTextTheme.head4),
                      FGBPDropdownMenu(
                        items: controller.categories.value,
                        hints: "Album Category",
                        value: controller.categories.value.isNotEmpty
                            ? controller.categories.value.first.id
                            : null,
                        onChanged: (value) {
                          controller.selectedCategory.value = value;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              controller.obx(
                (_) => Obx(
                  () => FGBPKeyboardReactiveButton(
                    disabled: !controller.albumValidity,
                    onTap:
                        controller.albumValidity ? controller.makeAlbum : null,
                    child: Text(
                      "Next",
                      style: FGBPTextTheme.text2Bold.copyWith(
                        color: FGBPColors.White1,
                      ),
                    ),
                  ),
                ),
                onLoading: const FGBPKeyboardReactiveButton(
                  disabled: false,
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: FGBPColors.White1,
                      strokeWidth: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
