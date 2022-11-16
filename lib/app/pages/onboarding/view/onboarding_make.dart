import 'package:backup/app/core/theme/color_theme.dart';
import 'package:backup/app/core/theme/text_theme.dart';
import 'package:backup/app/pages/onboarding/controller.dart';
import 'package:backup/app/widgets/button.dart';
import 'package:backup/app/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingMakePage extends StatelessWidget {
  OnboardingMakePage({Key? key}) : super(key: key);

  final OnboardingPageController controller =
      Get.find<OnboardingPageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, size: 16),
        onPressed: () {
          Get.back();
        },
      )),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(44),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Enter Your Family Name",
                      style: FGBPTextTheme.head2,
                    ),
                    const SizedBox(height: 50),
                    FGBPTextField(
                      controller: controller.nameController,
                      hintText: "Family Name",
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),
              controller.obx(
                (_) => Obx(
                  () => FGBPKeyboardReactiveButton(
                    disabled: !controller.inputValidity,
                    onTap: controller.inputValidity
                        ? controller.createFamily
                        : null,
                    child: Text(
                      "Create Family",
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
