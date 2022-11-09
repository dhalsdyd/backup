import 'package:backup/app/core/theme/color_theme.dart';
import 'package:backup/app/core/theme/text_theme.dart';
import 'package:backup/app/pages/onboarding/controller.dart';
import 'package:backup/app/widgets/button.dart';
import 'package:backup/app/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingInitPage extends StatelessWidget {
  OnboardingInitPage({Key? key}) : super(key: key);

  final OnboardingPageController controller =
      Get.find<OnboardingPageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      "Enter Your Name",
                      style: FGBPTextTheme.head2,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "This name is only seen to your family. ",
                      style: FGBPTextTheme.text2,
                    ),
                    Text("${controller.inputValidity}"),
                    const SizedBox(height: 50),
                    FGBPTextField(
                      hintText: "Enter Your Name",
                      controller: controller.nameController,
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),
              controller.obx(
                (_) => Obx(
                  () => FGBPKeyboardReactiveButton(
                    disabled: !controller.inputValidity,
                    onTap:
                        controller.inputValidity ? controller.enterName : null,
                    child: const Text(
                      "Next",
                      style: FGBPTextTheme.text2Bold,
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
