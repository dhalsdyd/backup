import 'package:backup/app/core/theme/text_theme.dart';
import 'package:backup/app/routes/route.dart';
import 'package:backup/app/widgets/button.dart';
import 'package:backup/app/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingMakePage extends StatelessWidget {
  const OnboardingMakePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
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
                      hintText: "Family Name",
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),
              FGBPMediumTextButton(
                text: "Create Family",
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
