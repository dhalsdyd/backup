import 'package:backup/app/core/theme/text_theme.dart';
import 'package:backup/app/routes/route.dart';
import 'package:backup/app/widgets/button.dart';
import 'package:backup/app/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterInitPage extends StatelessWidget {
  const RegisterInitPage({Key? key}) : super(key: key);

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
                      "This name is only seen to your family.",
                      style: FGBPTextTheme.text2,
                    ),
                    const SizedBox(height: 50),
                    FGBPTextField(
                      hintText: "Enter Your Name",
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),
              FGBPMediumTextButton(
                text: "Next",
                onTap: () {
                  Get.toNamed(Routes.register_code);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
