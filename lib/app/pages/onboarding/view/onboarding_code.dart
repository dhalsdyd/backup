import 'package:backup/app/core/theme/color_theme.dart';
import 'package:backup/app/core/theme/text_theme.dart';
import 'package:backup/app/pages/onboarding/controller.dart';
import 'package:backup/app/routes/route.dart';
import 'package:backup/app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OnboardingCodePage extends StatelessWidget {
  OnboardingCodePage({Key? key}) : super(key: key);

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
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 44, right: 44, bottom: 44),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Do you have Family Code?",
                      style: FGBPTextTheme.head2,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "It’s okay if you don’t have the code. You can create a new family group",
                      style: FGBPTextTheme.text2,
                    ),
                    const SizedBox(height: 50),
                    ConstrainedBox(
                      constraints:
                          const BoxConstraints(maxHeight: 300, maxWidth: 500),
                      child: PinCodeTextField(
                        controller: controller.pinController,
                        autoFocus: true,
                        appContext: context,
                        length: 6,
                        onChanged: (_) {},
                        onCompleted: (code) {
                          controller.enterFamily(code);
                        },
                        pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(10),
                            fieldHeight: 60,
                            fieldWidth: 45,
                            selectedColor: FGBPColors.Black1,
                            activeColor: FGBPColors.Black1,
                            inactiveColor: FGBPColors.Black3),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.onboarding_make);
                      },
                      child: Text("or, Make Family Group",
                          style: FGBPTextTheme.text2
                              .copyWith(decoration: TextDecoration.underline)),
                    ),
                  ],
                ),
              ),
              FGBPMediumTextButton(
                text: "Join the Family",
                onTap: () {
                  Get.toNamed(Routes.home);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
